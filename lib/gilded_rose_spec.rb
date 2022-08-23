require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  before do 
    @sulfuras = [Item.new('Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80)]
    @dexterity = [Item.new(name = '+5 Dexterity Vest', sell_in = 10, quality = 20)]
    @conjured = [Item.new(name = 'Conjured Mana Cake', sell_in = 3, quality = 6)]
    @backstage_1 = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 3, quality = 55)]
    @backstage_2 = [Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 10, quality = 46)]
  end  
  describe '#update_quality' do
    it 'does not change the quality' do
    GildedRose.new(@sulfuras).update_quality
    expect(@sulfuras[0].quality).to eq 80
    end
    it 'does not sell in' do
    GildedRose.new(@sulfuras).update_quality
    expect(@sulfuras[0].sell_in).to eq -1
    end
    it 'normal items decrease the quality with the passing of the days' do
    GildedRose.new(@dexterity).update_quality
    expect(@dexterity[0].quality).to eq 19
    end
    it 'conjured items degrade twice as fast as normal items' do
    GildedRose.new(@conjured).update_quality
    expect(@conjured[0].quality).to eq 4
    end
    it 'maximun quality for the backstage' do
    GildedRose.new(@backstage_1).update_quality
    expect(@backstage_1[0].quality).to eq 50
    end
    it 'The backstage increases quality +2  when the sell_in is  < 11' do
    GildedRose.new(@backstage_2).update_quality
    expect(@backstage_2[0].quality).to eq 48
  end
end
end


