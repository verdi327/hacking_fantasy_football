class League
  attr_reader :members

  def initialize(member_count)
    @members = register_members(member_count)
  end

  private

  def register_members(member_count)
    results = []
    (1..member_count).to_a.each do |order|
      results << Member.new(order)
    end
    results
  end
end

class Member
  attr_accessor :roster, :order, :checklist

  def initialize(order)
    @roster = []
    @order = order
    @checklist = ["QB", "RB", "RB", "WR", "WR", "TE", "FLEX", "DEF", "K"]
  end

  def choose(player)
    self.roster << player
    cross_off_checklist(player) unless checklist_completed?
  end

  def playable_team?
    h = Hash.new(0)
    roster.map(&:position).each do |p|
      h[p] += 1
    end
    h["QB"] >= 1 && h["RB"] >= 2 && h["WR"] >= 2 && h["TE"] >= 1 && h["DEF"] >= 1 && h["K"] >= 1
  end

  private

  def cross_off_checklist(player)
    if player.drafted_as_flex
      checklist.delete_if {|pos| pos == "FLEX"}
    else
      index = nil
      checklist.each_with_index do |item, i|
        if player.position == item
          index = i
          break
        end
      end
      checklist.delete_at(index)
    end
  end

  def checklist_completed?
    checklist.size == 0
  end
end