class Laser
  attr_reader :x, :y
  def initialize(player, window)
    @player = player
    @window = window
    @shooting = false
    @x = @player.x + 45
    @y = @player.y + 45
    @icon = Gosu::Image.new(@window, 'lightning.png', true)
  end

  def shoot
    @shooting = true
  end

  def update
    if @shooting
      @y = @y - 20
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
