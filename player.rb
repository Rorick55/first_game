class Player
  attr_reader :lives, :x, :y, :lasers, :bombs, :score, :bomb_count
  def initialize(window)
    @window = window
    @icon = Gosu::Image.new(@window, 'wizard-head.png', true)
    @x = 0
    @y = @window.height - @icon.width
    @explosion = Gosu::Image.new(@window, 'explosion.png', true)
    @exploded = false
    @lives = 5
    @score = 0
    @lasers = 10.times.map {Laser.new(self, @window)}
    @bombs = 10.times.map {Bomb.new(self, @window)}
    @bomb_count = 5
    #@lasers = [Laser.new(self, @window), Laser.new(self, @window), Laser.new(self, @window), Laser.new(self, @window)]
  end

  def update
    if @window.button_down? Gosu::KbLeft
      move_left
    end
    if @window.button_down? Gosu::KbRight
      move_right
    end
    if @window.button_down? Gosu::KbSpace
      @lasers.each do |laser|
        if laser.y == self.y + 45
          laser.shoot
        end
      end
    end
    if @window.button_down? Gosu::KbUp
      @bomb_count = @bomb_count - 1
      @bombs.each do |bomb|
        bomb.shoot
      end
    end
    if @bomb_count == 0
      @bombs = []
    end
    @lasers.each {|laser| laser.update}
    @bombs.each {|bomb| bomb.update}
  end

  def draw
    if @exploded
      @explosion.draw(@x, @y, 5)
    else
      @icon.draw(@x, @y, 3)
      @lasers.each {|laser| laser.draw}
      @bombs.each {|bomb| bomb.draw}
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

  def add_bombs
    if @bombs.length < 7
      @bombs << Bomb.new(self, @window)
    end
  end

  def increase_score(times)
    @score = score + (10*times)
  end

  def hit_by?(enemys)
    @exploded = enemys.any? {|enemy| Gosu::distance(enemy.x + 20, enemy.y + 20, @x + 50, @y + 50) < 40}
    if @exploded
      @lives = @lives - 1
    end
    @exploded
  end

  def reset_position
    @x = (@window.width - @icon.width) / 2
  end
end
