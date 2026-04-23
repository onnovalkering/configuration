# Show help if requested or if no arguments are provided.
if contains -- --help $argv; or test (count $argv) -ne 1
    echo "Usage: encrypt <file>"
    echo "Outputs an encrypted file to <file>.age"
    return 0
end

# Make sure the file is actually a file.
if not begin test -f "$argv[1]"; and test -s "$argv[1]"; end
    echo "Error: Input is not a non-empty file."
    return 1
end

age -p -o "$argv[1].age" "$argv[1]"
