class Enemy
    attr_reader :x, :y, :alive

  def initialize(window)
    @window = window
    @icon = Gosu::Image.new(@window, 'enemy.png', true)
    @y = - rand(1000)
    @x = rand(@window.width)
    @alive = true
  end

  def update(laser)
    @y = @y + (rand(7) + 4)
    if @y > @window.height
      @y= 0
      @x = rand(@window.width)
    end
    hit_by?(laser)
  end

  def draw
    @icon.draw(@x, @y, 4)
  end

  def hit_by?(laser)
    if Gosu::distance(laser.x + 20, laser.y + 20, @x + 20, @y + 20) < 20
      @alive = false
    end
  end


  def reset
    @x = -rand(1000)
    @y = rand(@window.width) - @icon.width
  end
end

