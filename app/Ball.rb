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
    @w = 32
    @h = 32
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


  def hasCollision(x, y, dx, dy, collision_grid)
    if collision_grid.get_int(x,y) != 0 && [@x + dx, @y + dy, 32, 32].intersect_rect?([x * 32, y * 32, 32,32])
      return collision_grid.get_int(x, y)
    else
      return 0
    end
  end 

  def tick args, collision_grid
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
      
      # Collision Détection

      # Destination tile
      dest_xa = ((@x + @vx )/32).to_i
      dest_ya = (@y / 32).to_i

      dest_xb = (@x / 32).to_i
      dest_yb = ((@y + @vy)  / 32).to_i

      
      # Check collision on x
      [[0,0], [0,1], [1,0], [1,1]].each do |tile|
        i = tile[0]
        j = tile[1]

        is_collide_on_x = hasCollision(dest_xa + i, dest_ya + j, @vx, 0, collision_grid)
        if is_collide_on_x == 1
          @vx *=  -1
          @angle = Math.atan2(@vy, @vx)
          break
        end
      end


      # And check collision on y
      [[0,0], [0,1], [1,0], [1,1]].each do |tile|
        i = tile[0]
        j = tile[1] 
        is_collide_on_y = hasCollision(dest_xb + i, dest_yb + j, 0, @vy, collision_grid)
        if is_collide_on_y == 1
          @vy *= -1
          @angle = Math.atan2(@vy, @vx)

        end
      end
      

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

