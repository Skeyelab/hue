require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

class Model
  include PassiveRecord
end

class Light < Model
  name
  belongs_to :bridge

end

class Bridge < Model
  has_many :lights
end

DEFAULT_TEMP = 366
DESIRED_TEMP = 233

light_array = []

client = Hue::Client.new
client.lights.each do |light|
  binding.pry
  puts light
end
binding.pry

loop do
  client = Hue::Client.new


  client.groups.each do |group|

    # if group.name == "Studio"
    #   group.lights.each do |light|
    #     unless light.instance_variable_get(:@state) == {"on"=>true, "bri"=>254, "ct"=>233, "alert"=>"none", "colormode"=>"ct", "reachable"=>true}
    #       puts "Setting #{light.name}"
    #       #binding.pry
    #       #light.set_state({"on"=>true, "bri"=>254, "ct"=>233, "alert"=>"none", "colormode"=>"ct", "reachable"=>true})
    #     end

    #   end
    # end

    if group.name == "Kitchen"
      group.lights.each do |light|
        binding.pry
        if light.reachable?
          if light.color_temperature != DESIRED_TEMP
            puts "Current CT: #{light.color_temperature}"
            puts "Setting #{light.name}"
            light.color_temperature = DESIRED_TEMP
          else
            puts "Current CT: #{light.color_temperature}"
          end
        else
          puts "#{light.name} unreachable"
        end
      end
    end

    #puts light.name
    #puts light.instance_variable_get(:@state)

    #group = nil

  end
  sleep(1.0/24.0)
end
