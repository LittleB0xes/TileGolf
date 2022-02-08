require 'lib/LDtkBridge.rb'
require 'app/Game.rb'
require 'app/Ball.rb'


def tick args
  if args.tick_count == 0
    $game = Game.new(args)
  end

  $game.args = args
  $game.tick
end
