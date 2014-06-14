class Window < Gosu::Window
  def initialize
    super(700, 600, false)
    @player = Player.new(self)
    @enemys = [Enemy.new(self), Enemy.new(self)]
    @enemys = 3.times.map {Enemy.new(self)}
    @running = true
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def draw
    @player.draw
    @enemys.each {|enemy| enemy.draw}
    @font.draw("Lives:#{@player.lives}", 10, 10, 3.0, 1.0, 1.0, 0xffffffff)
  end

  def update
    if @running
      if @player.hit_by?(@enemys)
        #game ends
        @running = false
      else
        run_game
      end
    end

    if @running == false and button_down? Gosu::Button::KbR and @player.lives > 0
      @running = true
      @player.reset_position
    end
  end

  def run_game
   if button_down? Gosu::KbLeft
      @player.move_left
    end
    if button_down? Gosu::KbRight
      @player.move_right
    end
    @enemys.each {|enemy| enemy.update}
  end
end
