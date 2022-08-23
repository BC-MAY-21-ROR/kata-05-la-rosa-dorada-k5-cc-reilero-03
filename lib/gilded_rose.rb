# frozen_string_literal: true

require_relative 'item_factory'
require_relative 'item_subclasses'
# This class handles days passing by and items sold in the inn
class GildedRose
  attr_reader :inventory
  def initialize(items)
    @inventory = []
    group_items(items)
  end

  def group_items(items)
    items.each do |item|
      @inventory << ItemFactory.create_obj(item)
    end
  end

  def update_quality
    @inventory.each(&:update_data)
  end
end

# Item class, do not touch
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
