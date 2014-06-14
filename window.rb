class Window < Gosu::Window
  def initialize
    super(800, 800, false)
    @player = Player.new(self)
  end

  def draw
    @player.draw
  end

  def update
    if button_down? Gosu::KbLeft
      @player.move_left
    end
    if button_down? Gosu::KbRight
      @player.move_right
    end
  end
end
