# frozen_string_literal: true

# This class add item objects to their respective class, grouped by its properties (quality, sell in calculations)
class ItemFactory
  def self.create_obj(item)
    item_name = item.name
    if item_name == 'Sulfuras, Hand of Ragnaros'
      Sulfuras.new(item)
    elsif item_name == 'Aged Brie'
      AgedBrie.new(item)
    elsif item_name.include? 'Backstage passes'
      BackstagePasses.new(item)
    elsif item_name.include? 'Conjured'
      ConjuredItems.new(item)
    else
      NormalItems.new(item)
    end
  end
end
