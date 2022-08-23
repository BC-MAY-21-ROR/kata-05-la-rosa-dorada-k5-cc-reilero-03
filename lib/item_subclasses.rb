# frozen_string_literal: true

# This is the class for items that has no specific rules about degrading quality or approaching its sell by date

class NormalItems
  attr_reader :quality, :sell_in
  def initialize(item)
    @item = item
    @quality = item.quality
    @sell_in = item.sell_in
  end

  def update_quality(quality_degradation = 1)
    @quality -= if @sell_in.negative?
                  quality_degradation * 2 else
                                            quality_degradation end
    @quality = 0 if @quality.negative?
  end

  def update_sell_in
    @sell_in -= 1
  end

  def update_data
    update_quality
    update_sell_in
    @item.sell_in = @sell_in
    @item.quality = @quality
  end
end

# This class represents the behavior of Conjured items(its quality changes as time pass by)
class ConjuredItems < NormalItems
  def update_quality
    super(2)
  end
end

# This class represents the behavior of Aged Brie items(its quality changes as time pass by)
class AgedBrie < NormalItems
  def update_quality
    @quality += 1 if @quality < 50
  end
end

# This class represents the behavior of Backstage passes (its quality changes as time pass by)
class BackstagePasses < NormalItems
  def update_quality
    @quality += if @sell_in < 11
                  2 elsif @sell_in < 6
                      3 elsif @sell_in.negative?
                          -@quality else
                                      1 end
    @quality = 50 if @quality > 50
  end
end

# This class has the properties for the legendary item sulfuras
class Sulfuras < NormalItems
  def update_quality; end

  def update_sell_in
    @sell_in = -1
  end
end
