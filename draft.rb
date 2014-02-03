require_relative "player"
require 'open-uri'

class Draft
  attr_reader :rounds
  attr_accessor :board

  def initialize(rounds, url)
    @rounds = rounds
    @board = set_board(url)
  end

  def highest_available(allowed_positions)
    drafted = nil
    board.each do |player|
      if allowed_positions.size == 0 || allowed_positions.include?(player.position) || can_draft_as_flex?(player)
        drafted = player
        break
      end
    end
    remove(drafted)
    drafted
  end

  private

  def can_draft_as_flex?(player)
    if player.flex?
      player.drafted_as_flex = true
      true
    else
      false
    end
  end

  def remove(drafted)
    board.delete_if { |player| player == drafted}
  end

  def fetch_data(url)
    Nokogiri::HTML(open(url)).css("table tr.last")
  end

  def set_board(url)
    page = fetch_data(url)
    results = page.map do |data|
      data.text.split("\t").delete_if(&:empty?)
    end
    results.map do |r|
      Player.new({
                  overall_rank: r[0].to_i,
                  name: r[1].split(",").first.strip,
                  team: r[1].split(",").last.strip,
                  bye: r[2].to_i,
                  position: filter_pos(r[3]),
                  position_rank: filter_pos_rank(r[3])
                })
    end
  end

  def filter_pos(string)
    string.match(/(\D+)/).captures.first
  end

  def filter_pos_rank(string)
    string.match(/(\d+)/).captures.first.to_i
  end
end