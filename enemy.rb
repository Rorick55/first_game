class Enemy
    attr_reader :x, :y, :alive

  def initialize(window)
    @window = window
    @icon = Gosu::Image.new(@window, 'enemy.png', true)
    @y = - rand(1000)
    @x = rand(@window.width)
    @alive = true
    @explosion = Gosu::Image.new(@window, 'explosion_small.png', true)
  end

  def update(laser)
    @y = @y + 3
    if @y > @window.height
      @y= 0
      @x = rand(@window.width)
    end
    hit_by?(laser)
  end

  def draw(lasers, bombs)
    if lasers.any? {|laser| Gosu::distance(laser.x + 20, laser.y + 20, @x + 20, @y + 20) < 50} or bombs.any? {|bomb| Gosu::distance(bomb.x + 20, bomb.y + 20, @x + 20, @y + 20) < 50}
      @explosion.draw(@x - 40, @y - 50,4)
    else
      @icon.draw(@x, @y, 4)
    end
  end

  def hit_by?(lasers)
    if lasers.any? {|laser| Gosu::distance(laser.x + 20, laser.y + 20, @x + 20, @y - 20) < 50}

      @alive = false
    end
  end


  def reset
    @y = -rand(1000)
    @x = rand(@window.width) - @icon.width
  end
end

