function __toggle_command_prefix \
  --description "Toggle a prefix at the beginning of the command line"

  set -l prefix $argv[1]
  set -l buffer (commandline)
  set -l cursor (commandline -C)

  if test -z "$buffer"
    set buffer $history[1]
  end

  if string match -qr "^$prefix\\s" -- $buffer
    set buffer (string replace -r "^$prefix\\s" '' -- $buffer)
    set cursor (math max 0 $cursor - (string length $prefix) - 1)
  else
    set buffer "$prefix $buffer"
    set cursor (math $cursor + (string length $prefix) + 1)
  end

  commandline -r -- $buffer
  commandline -C -- $cursor
end
