class Player
  def initialize(window)
    @window = window
    @icon = Gosu::Image.new(@window, 'spaceship.png', true)
    @x = 0
    @y = @window.height - @icon.width
  end

  def draw
    @icon.draw(@x, @y, 1)
  end

  def move_left
    @x = @x - 10
    if @x < 0
      @x = 0
    end
  end

  def move_right
    @x = @x + 10
    if @x > @window.width - 100
      @x = @window.width - 100
    end
  end
end
