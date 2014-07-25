class Timer
  def initialize(window, enemies, player)
    @enemies = enemies
    @window = window
    @player = player
    @start_time = Time.now
    @every_n_seconds = 5
    @last_recorded_seconds = 0
    @last_second
  end

  def update
    (@last_recorded_seconds/4).times {@enemies << Enemy.new(@window)} if add_enemies?
    @player.add_bombs if add_bombs?
  end

  def seconds
    (Time.now - @start_time).to_i
  end

  def add_enemies?
    if seconds != @last_recorded_seconds and seconds % @every_n_seconds == 0
      @last_recorded_seconds = seconds
      true
    else
      false
    end
  end

  def add_bombs?
    if seconds != @last_second and seconds % 5 == 0
       @last_second = seconds
      true
    else
      false
    end
  end
end

