function with_prefix_bind \
    --description "Bind a key sequence to with_prefix <prefix>"

    # We require exactly two arguments:
    #   1. key sequence (fish escape form)
    #   2. prefix string (e.g. 'sudo', 'proxychains -q')
    if test (count $argv) -ne 2
        echo "Usage: with_prefix_bind <key_sequence> <prefix>"
        return 1
    end

    set -l key_sequence $argv[1]
    set -l prefix $argv[2]

    # Defensive check: ensure with_prefix exists
    if not functions -q with_prefix
        echo "with_prefix function not found"
        return 1
    end

    # Bind in both insert and default modes
    # This matches how fzf.fish does it
    for mode in default insert
        bind --mode $mode $key_sequence "with_prefix \"$prefix\""
    end
end


