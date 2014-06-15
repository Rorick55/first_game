class Window < Gosu::Window
  def initialize
    super(800, 600, false)
    @player = Player.new(self)
    @enemys = [Enemy.new(self), Enemy.new(self)]
    @enemys = rand(8).times.map {Enemy.new(self)}
    @running = true
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @background = Gosu::Image.new(self, 'space.png', true)
  end

  def draw
    @player.draw
    live_enemys.each {|enemy| enemy.draw}
    @font.draw("Lives:#{@player.lives}", 10, 10, 3.0, 1.0, 1.0, 0xffffffff)
    @background.draw(0, 0, 1)
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
      @enemys.each {|enemy| enemy.reset}
      @running = true
      @player.reset_position
    end
  end

  def live_enemys
    @enemys.select {|enemy| enemy.alive == true}
  end

  def run_game
    live_enemys.each {|enemy| enemy.update(@player.laser)}
    @player.update
  end
end
