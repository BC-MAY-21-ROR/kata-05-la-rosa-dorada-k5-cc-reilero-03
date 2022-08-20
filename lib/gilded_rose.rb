class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      Item_factory.create_obj(item)
    end
    Normal_items.update_data
    Conjured.update_data
    Aged_brie.update_data
    Backstage_passes.update_data
    Sulfuras.update_data
  end
end


class Item_factory

  def self.create_obj(item)
    
    if item.name == "Sulfuras, Hand of Ragnaros"
      Sulfuras.add_item(item)
    elsif item.name == "Aged Brie"
      Aged_brie.add_item(item)
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      Backstage_passes.add_item(item)
    elsif item.name == "Conjured Mana Cake"
      Conjured.add_item(item)
    else
      Normal_items.add_item(item)
    end

  end
end

class Normal_items
  def initialize
    
  end

  def self.add_item(item)
    @items = [] if @items.nil?   
    @items << item
  end

  def self.update_quality
    @items.each do |item|
      if item.quality > 0
        item.quality -= if item.sell_in < 0 
        2 else 1 end
      end
    end
  end

  def self.update_sell_in
    @items.each do |item|
      item.sell_in -= 1
    end
  end

  def self.update_data
    self.update_quality
    self.update_sell_in
  end
end

class Special_items < Normal_items

end

class Conjured < Normal_items
  def self.update_quality
    @items.each do |item|
      if item.quality > 0
        item.quality -= if item.sell_in < 0 
        4 else 2 end
      end
    end
  end
end

class Aged_brie < Special_items
  def self.update_quality
    @items.each do |item|
      if item.quality < 50
        item.quality += 1
      end
    end
  end
end

class Backstage_passes < Special_items
  def self.update_quality
    @items.each do |item|
      if item.quality < 50
        if item.sell_in <= 0
          item.quality = 0 
        elsif  item.sell_in < 6
          item.quality += 3
        elsif  item.sell_in < 11
          item.quality += 2
        else 
          item.quality += 1
        end
      end 
    end
  end
end

class Sulfuras < Special_items
  def self.update_quality
  end

  def self.update_sell_in
    @items.each do |item|
      item.sell_in = -1
    end
  end
  
end


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
