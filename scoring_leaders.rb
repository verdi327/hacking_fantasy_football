require 'csv'
require 'ostruct'

class ScoringLeaders
  attr_accessor :players

  def initialize(filename)
    @players = set_rankings(filename)
  end

  def remove(drafted)
    players.delete_if {|player| player.name == drafted.name}
  end

  private

  def set_rankings(filename)
    list = []
    CSV.foreach(filename) do |row|
      player = OpenStruct.new(name: row[0], score: row[1].to_i )
      list << player
    end
    list
  end
end