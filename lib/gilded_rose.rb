#This class handles days passing by and items sold in the inn
class GildedRose

  def initialize(items)
    @items = items
    group_items
  end

  def group_items
    @items.each do |item|
      Item_factory.create_obj(item)
    end
  end

  def update_quality
    Normal_items.update_data
    Conjured.update_data
    Aged_brie.update_data
    Backstage_passes.update_data
    Sulfuras.update_data
  end
end

#This class add item objects to their respective class, grouped by its properties (quality, sell in calculations)
class Item_factory
  def self.create_obj(item)
    item_name = item.name
    if item_name == "Sulfuras, Hand of Ragnaros"
      Sulfuras.add_item(item)
    elsif item_name == "Aged Brie"
      Aged_brie.add_item(item)
    elsif item_name == "Backstage passes to a TAFKAL80ETC concert"
      Backstage_passes.add_item(item)
    elsif item_name == "Conjured Mana Cake"
      Conjured.add_item(item)
    else
      Normal_items.add_item(item)
    end

  end
end

#This is the class for items that has no specific rules about degrading quality or approaching its sell by date
class Normal_items
  def initialize
  end

  def self.add_item(item)
    (@items ||= []) << item
  end

  def self.update_quality(quality_degradation = 1)
    @items.each do |item|
      item.quality -= if item.sell_in < 0 
      quality_degradation*2 else quality_degradation end
      item.quality=0 if item.quality<0
    end
  end

  def self.update_sell_in
    @items.each do |item|
      item.sell_in -= 1
    end
  end

  def self.update_data
    unless @items.nil? 
      self.update_quality
      self.update_sell_in
    end
  end
end

#This class represents the behavior of Conjured items(its quality changes as time pass by)
class Conjured < Normal_items
  def self.update_quality
    super(quality_degradation=2)
  end
end

#This class represents the behavior of Aged Brie items(its quality changes as time pass by)
class Aged_brie < Normal_items
  def self.update_quality
    @items.each do |item|
      if item.quality < 50
        item.quality += 1
      end
    end
  end
end

#This class represents the behavior of Backstage passes (its quality changes as time pass by)
class Backstage_passes < Normal_items
  def self.update_quality
    @items.each do |item|
      item_sell_in = item.sell_in
      item.quality += if item_sell_in <11
        2 elsif item_sell_in < 6
        3 elsif item_sell_in < 0
        -item.quality else
        1 end
        item.quality = 50 if item.quality>50
    end
  end
end

#This class has the properties for the legendary item sulfuras
class Sulfuras < Normal_items
  def self.update_quality
  end

  def self.update_sell_in
    @items.each do |item|
      item.sell_in = -1
    end
  end
  
end

#Item class, do not touch
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
