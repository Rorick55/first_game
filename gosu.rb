require 'gosu'

class GameWindow < Gosu::Window

  def initialize(width, height, fullscreen)
    super(width, height, fullscreen)

    @sprite = Gosu::Image.new(self, "Smoke.png", false)
    @x = 800/2
    @y = 600/2
    @total_time = 0

  end

  def update
    @total_time += 16.0
    @y = (600/2) + Math.sin(@total_time * 0.01) * 100
  end

  def draw
    @sprite.draw(@x, @y, 0)
  end


end
game_window = GameWindow.new(800, 600, false)

game_window.show
