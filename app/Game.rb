class Game
  attr_gtk
  attr_reader :golf,
              :level,
              :collision_grid

  def initialize args
    @args = args
    @golf = LDtk::LDtkBridge.new('assets/Golf.ldtk')
    @level_name = :Level_0
    @level = @golf.get_level(@level_name)
    @collision_grid = @level.get_layer(:CollisionGrid)

    @ball = Ball.new(200, 200)
    outputs.static_sprites << {
      x: 0,
      y: 0,
      w: 1280,
      h: 720,
      path: "assets/Golf/png/" + @level_name.to_s + "-Ground.png",
    }
    outputs.static_sprites << @ball
    
  end

  def tick
    outputs.background_color = [0,0,0]
    @ball.tick args, @collision_grid

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
