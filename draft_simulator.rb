require_relative "draft"
require_relative "league"

draft = Draft.new(16, "avg_draft_position_2013.csv")
league = League.new(12, 1)

(1..(draft.rounds)).to_a.each do |round|
  if round.odd?
    league.members.each do |member|
      member.choose(draft.highest_available(member, round))
    end
  else
    league.members.reverse.each do |member|
      member.choose(draft.highest_available(member, round))
    end
  end

end

league.scoreboard
