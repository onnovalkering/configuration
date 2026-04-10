if not command -q git
    echo "git not found"
    return 1
end

if not command -q opencode
    echo "opencode not found"
    return 1
end

if not command -q jq
    echo "jq not found"
    return 1
end

if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
    echo "Not in a git repository"
    return 1
end

if git diff --cached --quiet 2>/dev/null
    echo "Nothing staged. Use 'git add' first."
    return 1
end

echo "Generating commit message..."

# Run opencode with JSON output, extract text parts, concatenate them.
set -l json (opencode run --command generate-commit-message 2>/dev/null)

# The model output should be a JSON object with subject and body.
set -l subject (echo $json | jq -r '.subject // empty' 2>/dev/null)
set -l body (echo $json | jq -r '.body // empty' 2>/dev/null | string collect)

if test -z "$subject"
    echo "Failed to generate commit message."
    echo "Raw output:"
    echo $json
    return 1
end

if test -n "$body"
    git commit -e -m "$subject" -m "$body"
else
    git commit -e -m "$subject"
end
