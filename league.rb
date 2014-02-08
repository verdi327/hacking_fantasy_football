class League
  attr_reader :members

  def initialize(member_count, smart_position)
    @members = register_members(member_count, smart_position)
  end

  def scoreboard
    members.sort_by {|member| -member.total_points}.each do |member|
      puts "[Member #{member.order}: #{member.total_points} total points]"
      puts member.roster.map {|p| "#{p.position} - #{p.name} - #{p.score}pts" }
      puts ""
    end
  end

  def winner
    winner = members.sort_by {|member| -member.total_points}.first
    puts "[Member #{winner.order}: #{winner.total_points} total points]"
    puts winner.roster.map {|p| "#{p.position} - #{p.name} - #{p.score}pts" }
  end

  private

  def register_members(member_count, smart_position)
    results = []
    (1..member_count).to_a.each do |order|
      if order == smart_position
        results << Member.new(order, true)
      else
        results << Member.new(order)
      end
    end
    results
  end
end

class Member
  attr_accessor :roster, :order, :checklist, :smart

  def initialize(order, smart=false)
    @roster = []
    @order = order
    @checklist = ["QB", "RB", "RB", "WR", "WR", "TE", "FLEX", "DEF", "K"]
    @smart = smart
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

  def total_points
    roster.inject(0) {|total, player| total += player.score}
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