require_relative "draft"
require_relative "league"
require "rubygems"
require "bundler/setup"
Bundler.require

espn_top_300 = "http://espn.go.com/fantasy/football/story/_/page/2013preseasonFFLranks250/top-300-position"

draft = Draft.new(16, espn_top_300)
league = League.new(10)

(1..(draft.rounds)).to_a.each do |round|
  if round.odd?
    league.members.each do |member|
      member.choose(draft.highest_available(member.checklist))
    end
  else
    league.members.reverse.each do |member|
      member.choose(draft.highest_available(member.checklist))
    end
  end

end
