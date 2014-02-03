class Player
  attr_reader :overall_rank, :name, :team, :bye, :position, :position_rank
  attr_accessor :drafted_as_flex

  def initialize(attrs)
    @overall_rank  = attrs[:overall_rank]
    @name          = attrs[:name]
    @team          = attrs[:team]
    @bye           = attrs[:bye]
    @position      = attrs[:position]
    @position_rank = attrs[:position_rank]
    @drafted_as_flex = false
  end

  def flex?
    position == "WR" || position == "TE" || position == "RB"
  end

  def qb?
    position == "QB"
  end

  def rb?
    position == "RB"
  end

  def wr?
    position == "WR"
  end

  def te?
    position == "TE"
  end

  def def?
    position == "DEF"
  end

  def k?
    position == "K"
  end
end