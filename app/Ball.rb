class Ball
  attr_sprite

  attr_reader :inside,
              :drag,
              :drag_x,
              :drag_y,
              :angle

  def initialize x, y

    @x = x
    @y = y
    @w = 48
    @h = 48
    @path = 'assets/ball.png'


    @vx = 0
    @vy = 0
    @angle = 0
    @speed = 0

    @inside = false
    @drag = false
    @drag_x = @x
    @drag_y = @y



  end

  def tick args
    if args.inputs.mouse.inside_circle?([@x + 0.5 * @w, @y + 0.5 * @h], @w * 0.5)
      @inside = true
    else
      @inside = false
    end
    if !@drag && @inside && args.inputs.mouse.button_left
      @drag = true
    end

    if @drag
      @drag_x = args.inputs.mouse.x
      @drag_y = args.inputs.mouse.y
      @angle = Math.atan2(((@y + 0.5 * @h) - @drag_y), ((@x + 0.5 * @w) - @drag_x))
      square_length = (@x + 0.5 * @w - @drag_x)**2 + (@y + 0.5 * @h - @drag_y)**2
      @speed = 0.25 * Math.sqrt(square_length)
    end

    if !@drag
      @speed *= 0.96
      @vx = @speed * Math.cos(@angle)
      @vy = @speed * Math.sin(@angle)
      @x += @vx
      @y += @vy
      if @x < 0 
        @vx *= -1
        @x = 0
        @angle = Math.atan2(@vy, @vx)
      elsif @x > 1280 - @w
        @vx *= -1
        @x = 1280 - @w
        @angle = Math.atan2(@vy, @vx)
      end
      if @y < 0
        @y = 0
        @vy *= -1
        @angle = Math.atan2(@vy, @vx)
      elsif @y > 720 - @h
        @y = 720 - @h
        @vy *= -1
        @angle = Math.atan2(@vy, @vx)
      end
    end


    if !args.inputs.mouse.button_left
      @drag = false
    end
  end

  def throw speed_vector

  end
end

