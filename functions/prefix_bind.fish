function prefix_bind \
  --description "Bind a key to toggle a command-line prefix"

  set -l key $argv[1]
  set -l prefix $argv[2]

  if test (count $argv) -ne 2
    echo "Usage: prefix_bind <key> <prefix>" >&2
    return 1
  end

  bind -M insert $key "__toggle_command_prefix '$prefix'"
end
