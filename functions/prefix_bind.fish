function prefix_bind
    # Bind a human-readable key sequence to toggle a prefix
    # Usage: prefix_bind <symbolic-key> <prefix>
    # Example: prefix_bind '\c\eP' "proxychains -q"

    set -l key $argv[1]    # Symbolic key sequence (e.g., \cs, \c\eP)
    set -l prefix $argv[2] # Command prefix

    # Validate arguments
    if test (count $argv) -ne 2
        echo "Usage: prefix_bind <key> <prefix>" >&2
        return 1
    end

    # Bind in insert mode (while typing commands)
    bind -M insert $key "__toggle_command_prefix '$prefix'"
end
