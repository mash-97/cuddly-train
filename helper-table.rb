require 'terminal-table'
require_relative './rules.rb'

class HelperTable
  attr_accessor :table
  def initialize(rules)
    @table = self.class.generateTable(rules)
  end

  def self.generateTable(rules)
    rows = []
    rules.moves.each_with_index do |um, umi|
      rows << [um]+[*rules.moves.length.times.collect{|cmi| rules.verdict(cmi, umi)}]
    end
    return Terminal::Table.new title: "Moves Table\n(User Point of View)", headings: ["v PC\\User >"]+rules.moves, rows: rows
  end
end