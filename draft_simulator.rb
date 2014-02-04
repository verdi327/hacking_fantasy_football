require_relative "draft"
require_relative "league"
require_relative "scoring_leaders"

avg_draft_results = "avg_draft_position_2013.csv"
year_end_results = "scoring_leaders_2013.csv"


draft = Draft.new(16, avg_draft_results)
league = League.new(12)
scoring_leaders = ScoringLeaders.new(year_end_results)

(1..(draft.rounds)).to_a.each do |round|
  if round.odd?
    league.members.each do |member|
      member.choose(draft.highest_available(member, round, scoring_leaders))
    end
  else
    league.members.reverse.each do |member|
      member.choose(draft.highest_available(member, round, scoring_leaders))
    end
  end

end
