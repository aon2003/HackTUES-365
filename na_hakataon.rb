
# 215 - 225 MNOGO VAJNI REDOVE ZA TEMITE NA VAPROSITE V STAITE

require 'gosu'
load 'wall.rb'
load 'player.rb'
load 'uchilishte.rb'
load 'questionss.rb'


module Zlay
  BACKGROUND = 0
  WALLS = 1
  UCHITELI = 2
  PLAYER = 3
  DOOR = 4
  DUSKA = 5
  ICONS = 6
  WHITEBOARD = 7
  TEXT = 8
  CURSOR = 10
end




class TheGame < Gosu::Window
  def initialize
    super 640, 480

    @background
    @bg_counter = 2
    @cursor = Gosu::Image.new("na_haka_snimki/cursor365.png")

    @t_or_f = Gosu::Font.new(15)

    @walls = [Wall.new(0, self.height/2, 0.3, 5),   # left
      Wall.new(self.width/2, 0, 7, 0.3),            # top
      Wall.new(self.width, self.height/2, 0.3, 5),  # right
      Wall.new(self.width/2, self.height, 7, 0.3)]  # bottom

    @igrach = Player.new(self.width/2, self.height/2)

    @zhana = Uchitel.new(900, 900, "na_haka_snimki/Abramovichotgore.png")
    @duska_zhana = Duska.new(45, 30, "na_haka_snimki/abramovich_small.png")

    @mitova = Uchitel.new(900, 900, "na_haka_snimki/mitovaotgore_usable.png")
    @duska_mitova = Duska.new(45, 30, "na_haka_snimki/mitova_small.png")


    @milko = Uchitel.new(900, 900, "na_haka_snimki/whiteboard.png")
    @duska_milko = Duska.new(45, 30, "na_haka_snimki/whiteboard.png")


    @door_top = Door.new(500, 0)
    @door1 = true
    @door2 = false
    @door3 = false


  end


  def update
    if Gosu.button_down? Gosu::KB_W
      @igrach.go_up
    end

    if Gosu.button_down? Gosu::KB_A
      @igrach.go_left
    end

    if Gosu.button_down? Gosu::KB_S
      @igrach.go_down
    end

    if Gosu.button_down? Gosu::KB_D
      @igrach.go_right
    end

    unless (Gosu.button_down? Gosu::KB_W) || (Gosu.button_down? Gosu::KB_A) || (Gosu.button_down? Gosu::KB_S) || (Gosu.button_down? Gosu::KB_D)
      @igrach.still
    end

    @igrach.y = self.height - 30 if @igrach.y > self.height - 30 && @bg_counter != 3 && @bg_counter != 4 && @bg_counter != 5


    case @bg_counter
    when -2  # =================================
      @background = Gosu::Image.new("na_haka_snimki/lafka_.png")

      if @igrach.x > self.width - 30
        @bg_counter = -1
        @igrach.x = 30
      end

      @igrach.y = 30 if @igrach.y < 30
      @igrach.x = 30 if @igrach.x < 30
    when -1 # =================================
      @background = Gosu::Image.new("na_haka_snimki/koridor.png")

      if @igrach.x > self.width - 30
        @bg_counter = 0
        @igrach.x = 30
      end

      if @igrach.y < 30
        if Gosu.distance(@igrach.x, @igrach.y, @door_top.x, @door_top.y) < 40 && @door3 # ZAKLUCHENA
          @bg_counter = 5
          @igrach.y = self.height - 30
        else
          @igrach.y = 30
        end
      end

      if @igrach.x < 0
        @bg_counter = -2
        @igrach.x = self.width - 30
      end

    when 0 # =================================
      @background = Gosu::Image.new("na_haka_snimki/koridorsdivan.png")

      if @igrach.x > self.width
        @bg_counter = 1
        @igrach.x = 30
      end

      if @igrach.x < 0
        @bg_counter = -1
        @igrach.x = self.width - 30
      end

      if @igrach.y < 30
        if Gosu.distance(@igrach.x, @igrach.y, @door_top.x, @door_top.y) < 40 && @door2 # ZAKLUCHENA
          @bg_counter = 4
          @igrach.y = self.height - 30
        else
          @igrach.y = 30
        end
      end

    when 1 # =================================
      @background = Gosu::Image.new("na_haka_snimki/koridor.png")

      if @igrach.y < 30
        if Gosu.distance(@igrach.x, @igrach.y, @door_top.x, @door_top.y) < 40 && @door1 # OTKLUCHENA
          @bg_counter = 3
          @igrach.y = self.height - 30
        else
          @igrach.y = 30
        end
      end

      if @igrach.x < 0
        @bg_counter = 0
        @igrach.x = self.width - 30
      end

      if @igrach.x > self.width
        @bg_counter = 2
        @igrach.x = 30
      end

    when 2 # =================================
      @background = Gosu::Image.new("na_haka_snimki/radiatori.png")

      @igrach.y = 30 if @igrach.y < 30

      if @igrach.x < 0
        @bg_counter = 1
        @igrach.x = self.width - 30
      end
      @igrach.x = self.width - 30 if @igrach.x > self.width - 30

    when 3 # =================================
      @background = Gosu::Image.new("na_haka_snimki/staq.png")
      @igrach.x = 50 if @igrach.x < 50
      @igrach.x = self.width - 50 if @igrach.x > self.width - 50

      @igrach.y = 40 if @igrach.y < 40
      if @igrach.y > self.height-30
        if Gosu.distance(@igrach.x, @igrach.y, 500, self.height) < 40
          @bg_counter = 1
          @igrach.y = 30
        else
          @igrach.y = self.height - 30
        end
      end

    when 4 # =================================
      @background = Gosu::Image.new("na_haka_snimki/staq.png")
      @igrach.x = 50 if @igrach.x < 50
      @igrach.x = self.width - 50 if @igrach.x > self.width - 50

      @igrach.y = 40 if @igrach.y < 40
      if @igrach.y > self.height-30
        if Gosu.distance(@igrach.x, @igrach.y, 500, self.height) < 40
          @bg_counter = 0
          @igrach.y = 30
        else
          @igrach.y = self.height - 30
        end
      end

    when 5 # =================================
      @background = Gosu::Image.new("na_haka_snimki/staq.png")
      @igrach.x = 50 if @igrach.x < 50
      @igrach.x = self.width - 50 if @igrach.x > self.width - 50

      @igrach.y = 40 if @igrach.y < 40
      if @igrach.y > self.height-30
        if Gosu.distance(@igrach.x, @igrach.y, 500, self.height) < 40
          @bg_counter = -1
          @igrach.y = 30
        else
          @igrach.y = self.height - 30
        end
      end
    end


    @bg_counter == 3 ? @zhana.goto(500, 130) : @zhana.goto(900, 900)
    Gosu.distance(@igrach.x, @igrach.y, @zhana.x, @zhana.y) < 75 ? @duska_zhana.drawable = true : @duska_zhana.drawable = false
    @duska_zhana.predmet = 0

    @bg_counter == 4 ? @mitova.goto(500, 130) : @mitova.goto(900, 900)
    Gosu.distance(@igrach.x, @igrach.y, @mitova.x, @mitova.y) < 75 ? @duska_mitova.drawable = true : @duska_mitova.drawable = false
    @duska_mitova.predmet = 1

    @bg_counter == 5 ? @milko.goto(500, 130) : @milko.goto(900, 900)
    Gosu.distance(@igrach.x, @igrach.y, @milko.x, @milko.y) < 75 ? @duska_milko.drawable = true : @duska_milko.drawable = false
    @duska_milko.predmet = 2


    if @duska_zhana.drawable && button_down?(Gosu::MsLeft)
      if Gosu.distance(@duska_zhana.option_a.x, @duska_zhana.option_a.y, self.mouse_x, self.mouse_y) < 30
        puts "TRUE"
        @door2 = true
      end
      if Gosu.distance(@duska_zhana.option_b.x, @duska_zhana.option_b.y, self.mouse_x, self.mouse_y) < 30
        puts "FALSE"
      end
      if Gosu.distance(@duska_zhana.option_c.x, @duska_zhana.option_c.y, self.mouse_x, self.mouse_y) < 30
        puts "FALSE"
      end
    end

    if @duska_mitova.drawable && button_down?(Gosu::MsLeft)
      if Gosu.distance(@duska_mitova.option_a.x, @duska_mitova.option_a.y, self.mouse_x, self.mouse_y) < 30
        puts "FALSE"
      end
      if Gosu.distance(@duska_mitova.option_b.x, @duska_mitova.option_b.y, self.mouse_x, self.mouse_y) < 30
        puts "TRUE"
        @door3 = true
      end
      if Gosu.distance(@duska_mitova.option_c.x, @duska_mitova.option_c.y, self.mouse_x, self.mouse_y) < 30
        puts "FALSE"
      end
    end

    if @duska_milko.drawable && button_down?(Gosu::MsLeft)
      if Gosu.distance(@duska_milko.option_a.x, @duska_milko.option_a.y, self.mouse_x, self.mouse_y) < 30
        puts "FALSE"
      end
      if Gosu.distance(@duska_milko.option_b.x, @duska_milko.option_b.y, self.mouse_x, self.mouse_y) < 30
        puts "TRUE"
      end
      if Gosu.distance(@duska_milko.option_c.x, @duska_milko.option_c.y, self.mouse_x, self.mouse_y) < 30
        puts "FALSE"
      end
    end


end

  def draw
    @background.draw(0, 0, Zlay::BACKGROUND)
    @cursor.draw(self.mouse_x, self.mouse_y, Zlay::CURSOR)
    @walls.each do |wall|
      @walls[1].draw
      @walls[3].draw
      if @bg_counter == -2
        @walls[0].draw
      elsif @bg_counter == 2
        @walls[2].draw
      end
    end
    @igrach.draw

    @zhana.draw
    @duska_zhana.draw if @duska_zhana.drawable

    @mitova.draw
    @duska_mitova.draw if @duska_mitova.drawable


    @milko.draw
    @duska_milko.draw if @duska_milko.drawable

    @door_top.draw if @bg_counter != 2 && @bg_counter != -2 && @bg_counter != 3 && @bg_counter != 4 && @bg_counter != 5

  end

end

TheGame.new.show
