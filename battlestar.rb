require "pry-byebug"
require "gosu"

#Every Gosu application starts with a subclass of Gosu::Window. A minimal window class looks like this:

class Tutorial < Gosu::Window
  def initialize
    super 640,480 #fullscreen: true
    # Setting the Title of the window
    self.caption = "TUTORIAL GAME"
    # Setting the background image
    @background_image = Gosu::Image.new("./images/space.png", tileable: true)
    # Create our new player that we set on the player file
    @player = Player.new
    @player.warp(320,240)

    # Create the stars that i need to display
    @star_anim = Gosu::Image.load_tiles("./images/star.png", 25, 25)

    @stars = Array.new
    @font = Gosu::Font.new(20)
  end
  def update
    # This method it works to update each 60 times per second and here is going all the logic from game
    if Gosu.button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft
      @player.turn_left
    end
    if Gosu.button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight
      @player.turn_right
    end
    if Gosu.button_down? Gosu::KbUp or Gosu::button_down? Gosu::GpButton0
      @player.accelerate
    end
    if Gosu.button_down? Gosu::KbDown
      @player.move_back
    end
    #update the coordinations
    @player.move
    @player.collect_stars(@stars)

    if rand(100) < 4 and @stars.size < 25

        @stars.push(Star.new(@star_anim))
    end
  end
  def draw
    # This is to draw or re-drawn all scenario from scratch. The logic from game doesn't gave to go there

      @background_image.draw(0,0,0)
      @player.draw
      @stars.each(&:draw)
      @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0,1.0,Gosu::Color::YELLOW)
  end
  def button_down(id)
    id == Gosu::KbEscape ? close : super
  end
end
