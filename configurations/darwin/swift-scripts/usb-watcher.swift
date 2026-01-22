import Foundation
import IOKit
import IOKit.usb

// MARK: - Logging

enum Log {
    static func info(_ message: String) {
        fputs("\(message)\n", stdout)
        fflush(stdout)
    }

    static func error(_ message: String) {
        fputs("\(message)\n", stderr)
        fflush(stderr)
    }
}

// MARK: - Action Protocol

protocol USBAction {
    func execute()
}

// MARK: - Actions

struct NoopAction: USBAction {
    func execute() {
        Log.info("Noop action: device connected, no action taken")
    }
}

struct KickstartAction: USBAction {
    let serviceName: String
    let delay: TimeInterval

    init(serviceName: String, delay: TimeInterval = 1.0) {
        self.serviceName = serviceName
        self.delay = delay
    }

    func execute() {
        Thread.sleep(forTimeInterval: delay)

        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/bin/launchctl")
        process.arguments = ["kickstart", "-k", serviceName]

        do {
            try process.run()
            process.waitUntilExit()

            if process.terminationStatus == 0 {
                Log.info("Successfully triggered kickstart for \(serviceName)")
            } else {
                Log.error("launchctl exited with status \(process.terminationStatus)")
            }
        } catch {
            Log.error("Failed to run launchctl: \(error)")
        }
    }
}

// MARK: - USB Watcher

class USBWatcher {
    private let notifyPort: IONotificationPortRef
    private var addedIterator: io_iterator_t = 0
    private let deviceName: String
    private let action: USBAction

    init(deviceName: String, action: USBAction) {
        self.deviceName = deviceName
        self.action = action

        guard let port = IONotificationPortCreate(kIOMainPortDefault) else {
            fatalError("Failed to create IONotificationPort")
        }
        self.notifyPort = port

        let runLoopSource = IONotificationPortGetRunLoopSource(notifyPort).takeUnretainedValue()
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .defaultMode)

        guard let matchingDict = IOServiceMatching(kIOUSBDeviceClassName) else {
            fatalError("Failed to create matching dictionary")
        }

        let selfPtr = Unmanaged.passUnretained(self).toOpaque()
        let result = IOServiceAddMatchingNotification(
            notifyPort,
            kIOFirstMatchNotification,
            matchingDict,
            deviceAddedCallback,
            selfPtr,
            &addedIterator
        )

        guard result == KERN_SUCCESS else {
            fatalError("Failed to add matching notification: \(result)")
        }

        processDevices(addedIterator)
        Log.info("USB watcher started, monitoring for '\(deviceName)'")
    }

    deinit {
        IONotificationPortDestroy(notifyPort)
    }

    func processDevices(_ iterator: io_iterator_t) {
        while case let device = IOIteratorNext(iterator), device != 0 {
            defer { IOObjectRelease(device) }

            if let productName = getDeviceProperty(device, key: kUSBProductString as CFString) {
                if productName.contains(deviceName) {
                    Log.info("Target device '\(deviceName)' connected, triggering action...")
                    action.execute()
                }
            }
        }
    }

    private func getDeviceProperty(_ device: io_object_t, key: CFString) -> String? {
        guard let value = IORegistryEntryCreateCFProperty(device, key, kCFAllocatorDefault, 0) else {
            return nil
        }
        return value.takeRetainedValue() as? String
    }
}

private func deviceAddedCallback(refCon: UnsafeMutableRawPointer?, iterator: io_iterator_t) {
    let watcher = Unmanaged<USBWatcher>.fromOpaque(refCon!).takeUnretainedValue()
    watcher.processDevices(iterator)
}

// MARK: - Argument Parsing

struct Arguments {
    let deviceName: String
    let action: USBAction

    static func parse() -> Arguments? {
        let args = CommandLine.arguments

        guard args.count >= 2 else {
            return nil
        }

        let deviceName = args[1]

        // Parse action options
        if args.count == 3 && args[2] == "--noop" {
            return Arguments(deviceName: deviceName, action: NoopAction())
        }

        if args.count >= 4 && args[2] == "--kickstart" {
            let action = KickstartAction(serviceName: args[3])
            return Arguments(deviceName: deviceName, action: action)
        }

        return nil
    }

    static func printUsage() {
        print("""
            Usage: usb-watcher <device-name> <action>

            Actions:
              --noop                 Print when device connects, take no action (for testing)
              --kickstart <service>  Restart a launchd service when device connects

            Examples:
              usb-watcher "USB Receiver" --noop
            """)
    }
}

// MARK: - Main

guard let arguments = Arguments.parse() else {
    Arguments.printUsage()
    exit(1)
}

let watcher = USBWatcher(deviceName: arguments.deviceName, action: arguments.action)

withExtendedLifetime(watcher) {
    RunLoop.current.run()
}
