class Window < Gosu::Window
  def initialize
    super(800, 600, false)
    @player = Player.new(self)
    @enemies = [Enemy.new(self), Enemy.new(self)]
    @enemies = rand(6).times.map {Enemy.new(self)}
    @running = true
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @score = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @background = Gosu::Image.new(self, 'space.png', true)
    @timer = Timer.new(self, @enemies, @player)
  end

  def draw
    @player.draw
    live_enemies.each {|enemy| enemy.draw(@player.lasers, @player.bombs)}
    @font.draw("Lives:#{@player.lives}", 10, 10, 3.0, 1.0, 1.0, 0xffffffff)
    @score.draw("Score: #{@player.score}", 10, 40, 3.0, 1.0, 1.0, 0xffffffff)
    @background.draw(0, 0, 1)
  end

  def update
    if @running
      if @player.hit_by?(@enemies)
        #game ends
        @running = false
      else
        run_game
      end
    end
    if @running == false and button_down? Gosu::Button::KbR and @player.lives > 0
      @enemies.each {|enemy| enemy.reset}
      @running = true
      @player.reset_position
    end
  end

  def live_enemies
    @enemies.select {|enemy| enemy.alive == true}
  end

  def run_game
    live_enemies.each do |enemy|

      if enemy.update(@player.lasers) == false
        @player.increase_score(1)
      end
    end
    live_enemies.each do |enemy|
      if enemy.update(@player.bombs) == false
        @player.increase_score(1)
      end
    end
    @player.update
    @timer.update
  end
end
