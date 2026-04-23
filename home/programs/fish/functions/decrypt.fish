# Show help if requested or if no arguments are provided.
if contains -- --help $argv; or test (count $argv) -ne 1
    echo "Usage: decrypt <file.age>"
    echo "Outputs the decrypted file to <file> (removes the .age extension)"
    return 0
end

# Make sure the file actually ends in .age
if not string match -q "*.age" $argv[1]
    echo "Error: Input file must end with .age"
    return 1
end

# Strip the .age extension for the output filename
set -l output_file (string replace -r '\.age$' '' -- $argv[1])

age -d -o "$output_file" "$argv[1]"
