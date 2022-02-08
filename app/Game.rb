class Game
  attr_gtk
  def initialize args
    @args = args

    @ball = Ball.new(200, 200)
    outputs.static_sprites << @ball
  end

  def tick
    outputs.background_color = [0,0,0]
    @ball.tick args

    debug
  end

  def debug
    outputs.labels << [10, 700, "inside: #{@ball.inside}", 255,0,0]
    outputs.labels << [10, 680, "drag: #{@ball.drag}", 255,0,0]
    outputs.labels << [10, 660, "x-y: #{@ball.drag_x} - #{@ball.drag_y}", 255,0,0]
    outputs.labels << [10, 640, "angle: #{@ball.angle}", 255,0,0]
    if @ball.drag
      outputs.lines << [@ball.x + 0.5 * @ball.w, @ball.y + 0.5 * @ball.h, @ball.drag_x, @ball.drag_y, 255,255,255]
    end
    if inputs.keyboard.key_down.tab 
      $gtk.reset
    elsif inputs.keyboard.key_down.escape
      $gtk.exit
    end
  end
end
