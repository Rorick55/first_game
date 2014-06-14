class Player
  attr_reader :lives
  def initialize(window)
    @window = window
    @icon = Gosu::Image.new(@window, 'spaceship.png', true)
    @x = 0
    @y = @window.height - @icon.width
    @explosion = Gosu::Image.new(@window, 'explosion.png', true)
    @exploded = false
    @lives = 3
  end

  def draw
    if @exploded
      @explosion.draw(@x, @y, 4)
    else
      @icon.draw(@x, @y, 1)
    end
  end

  def move_left
    @x = @x - 10
    if @x < 0
      @x = 0
    end
  end

  def move_right
    @x = @x + 10
    if @x > @window.width - @icon.width
      @x = @window.width - @icon.width
    end
  end

  def hit_by?(enemys)
    @exploded = enemys.any? {|enemy| Gosu::distance(enemy.x + 20, enemy.y + 20, @x + 50, @y + 50) < 50}
    if @exploded
      @lives = @lives - 1
    end
    @exploded
  end

  def reset_position
    @x = rand(@window.width - @icon.width)
  end
end
