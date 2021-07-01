# Fixes `TypeError (no implicit conversion of Time into String)` until we can go to version 1 of que.
# Taken from https://github.com/que-rb/que/issues/247#issuecomment-595258236
Que::Adapters::Base::CAST_PROCS[1184] = lambda do |value|
  case value
  when Time then value
  when String then Time.parse(value)
  else raise "Unexpected time class: #{value.class} (#{value.inspect})"
  end
end
