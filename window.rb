class Window < Gosu::Window
  def initialize
    super(700, 600, false)
    @player = Player.new(self)
    @enemy = Enemy.new(self)
  end

  def draw
    @player.draw
    @enemy.draw
  end

  def update
    if button_down? Gosu::KbLeft
      @player.move_left
    end
    if button_down? Gosu::KbRight
      @player.move_right
    end
    @enemy.update
  end
end
