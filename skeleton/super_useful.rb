# PHASE 2
def convert_to_int(str)
  begin
    Integer(str)
  rescue ArgumentError => e
    puts e.message
  end
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  else
    raise StandardError.new("that's not a fruit")

  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp

    raise CoffeeError.new("Thanks for the coffee") if maybe_fruit == 'coffee'

    reaction(maybe_fruit)
  rescue CoffeeError => e
    puts e.message
    retry
  rescue StandardError => e
    puts e.message
  end

end

class CoffeeError < StandardError
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    begin
      @name = name
      raise ArgumentError.new("You didn't tell me your name!") if name.empty?
    rescue ArgumentError => e
      puts e.message
      return
    end

    begin
      @yrs_known = yrs_known
      raise ArgumentError.new("You are NOT my best friend!!!") if yrs_known < 5
    rescue ArgumentError => e
      puts e.message
      return
    end

    begin
      @fav_pastime = fav_pastime
      raise ArgumentError.new("You didn't tell me your favorite pastime!") \
        if fav_pastime.empty?
    rescue ArgumentError => e
      puts e.message
      return
    end
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
