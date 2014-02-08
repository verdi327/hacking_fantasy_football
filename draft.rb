require_relative "player"
require 'csv'

class Draft
  attr_reader :rounds
  attr_accessor :board

  def initialize(rounds, filename)
    @rounds = rounds
    @board = set_board(filename)
  end

  def highest_available(member, round)
    drafted = nil
    if member.smart
      board.sort_by {|p| -p.score}.each do |player|
        if round <= 9
          if member.checklist.size == 0 || member.checklist.include?(player.position) || can_draft_as_flex?(player)
            drafted = player
            break
          end
        else
          if member.checklist.size == 0 || member.checklist.include?(player.position)
            drafted = player
            break
          end
        end
      end
    else
      board.each do |player|
        if round <= 9
          if member.checklist.size == 0 || member.checklist.include?(player.position) || can_draft_as_flex?(player)
            drafted = player
            break
          end
        else
          if member.checklist.size == 0 || member.checklist.include?(player.position)
            drafted = player
            break
          end
        end
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

  def set_board(filename)
    list = []
    CSV.foreach(filename) do |row|
      list << Player.new(name: row[0], team: row[1], position: row[2], rank: row[3].to_i, score: row[4].to_i)
    end
    list.sort_by {|p| p.rank}
  end
end