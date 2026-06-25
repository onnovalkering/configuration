import Foundation

// Ensures every file under a directory tree is materialised on local disk
// (i.e. not an evicted iCloud Drive placeholder) before a backup runs.
//
// Exit codes:
//   0  all files are on disk (safe to back up, online or offline)
//   1  usage / source directory missing
//   2  files are still offline and cannot be downloaded (assume no internet)

// MARK: - Logging

func outLog(_ message: String) {
    FileHandle.standardOutput.write(Data((message + "\n").utf8))
}

func errLog(_ message: String) {
    FileHandle.standardError.write(Data((message + "\n").utf8))
}

// MARK: - Configuration

let fm = FileManager.default

// Default to ~/Documents; allow an override argument for testing.
let root: URL = {
    if CommandLine.arguments.count >= 2 {
        return URL(fileURLWithPath: CommandLine.arguments[1])
    }
    return fm.homeDirectoryForCurrentUser.appendingPathComponent("Documents")
}()

let resourceKeys: Set<URLResourceKey> = [
    .ubiquitousItemDownloadingStatusKey,
    .isDirectoryKey,
]

let pollInterval: TimeInterval = 5      // seconds between scans
let maxStalls = 12                      // ~60s of zero progress => offline
let overallDeadline = Date().addingTimeInterval(60 * 60) // 1h hard cap

// MARK: - Scanning

/// Regular files under `root` that iCloud has evicted (not on local disk).
func notDownloaded() -> [URL] {
    guard let enumerator = fm.enumerator(
        at: root,
        includingPropertiesForKeys: Array(resourceKeys),
        options: [],
        errorHandler: { url, error in
            errLog("warn: cannot access \(url.path): \(error.localizedDescription)")
            return true
        }
    ) else {
        return []
    }

    var result: [URL] = []
    for case let url as URL in enumerator {
        guard let values = try? url.resourceValues(forKeys: resourceKeys) else { continue }
        if values.isDirectory == true { continue }
        if values.ubiquitousItemDownloadingStatus == .notDownloaded {
            result.append(url)
        }
    }
    return result
}

func requestDownloads(_ urls: [URL]) {
    for url in urls {
        do {
            try fm.startDownloadingUbiquitousItem(at: url)
        } catch {
            errLog("warn: cannot start download for \(url.lastPathComponent): \(error.localizedDescription)")
        }
    }
}

// MARK: - Main

guard fm.fileExists(atPath: root.path) else {
    errLog("source directory not found: \(root.path)")
    exit(1)
}

var pending = notDownloaded()
if pending.isEmpty {
    outLog("all files already on disk")
    exit(0)
}

outLog("\(pending.count) offline file(s) found; requesting download…")
requestDownloads(pending)

var lastCount = pending.count
var stalls = 0

while true {
    Thread.sleep(forTimeInterval: pollInterval)

    pending = notDownloaded()
    if pending.isEmpty {
        outLog("all files downloaded")
        exit(0)
    }

    if pending.count < lastCount {
        stalls = 0
        lastCount = pending.count
        outLog("\(pending.count) file(s) remaining…")
    } else {
        stalls += 1
    }

    requestDownloads(pending)

    if stalls >= maxStalls {
        errLog("no download progress (\(pending.count) file(s) stuck) — assuming offline; aborting")
        exit(2)
    }
    if Date() > overallDeadline {
        errLog("timed out with \(pending.count) file(s) still offline; aborting")
        exit(2)
    }
}
