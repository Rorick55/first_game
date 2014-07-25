class Bomb
  attr_reader :x, :y
  def initialize(player, window)
    @player = player
    @window = window
    @x = @player.x + 45
    @y = @player.y + 45
    @xs = (-rand(10) + rand(10))
    @shooting = false
    @icon = Gosu::Image.new(@window, 'energy.png', true)
  end

  def shoot
    @shooting = true
  end

  def update
    if @shooting
      @player.bomb_count -= 1
      @y = @y - 10
      @x = @x - @xs
      if @y < 0
        @shooting = false
      end
    else
      @x = @player.x + 45
      @y = @player.y + 45
    end
  end

  def draw
    @icon.draw(@x, @y, 2)
  end
end
