class Player
  attr_reader :name, :team, :position
  attr_accessor :drafted_as_flex

  def initialize(attrs)
    @name          = attrs[:name]
    @team          = attrs[:team]
    @position      = attrs[:position]
    @drafted_as_flex = false
  end

  def flex?
    position == "WR" || position == "TE" || position == "RB"
  end
end