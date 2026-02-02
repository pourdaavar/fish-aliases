function __toggle_command_prefix
    # Toggle a prefix at the start of the current command line
    # Does nothing if the prompt is empty
    # Usage: __toggle_command_prefix "sudo" or "proxychains -q"

    set -l prefix $argv[1]             # Prefix to toggle
    set -l buffer (commandline)        # Current command line
    set -l cursor (commandline -C)     # Current cursor position

    # Exit early if buffer is empty
    if test -z "$buffer"
        return
    end

    # If prefix exists at the start, remove it
    if string match -qr "^$prefix\\s" -- $buffer
        set buffer (string replace -r "^$prefix\\s" '' -- $buffer)
        set cursor (math max 0 $cursor - (string length $prefix) - 1)
    else
        # Otherwise, add prefix at the start
        set buffer "$prefix $buffer"
        set cursor (math $cursor + (string length $prefix) + 1)
    end

    # Update command line and cursor
    commandline -r -- $buffer
    commandline -C -- $cursor
end
