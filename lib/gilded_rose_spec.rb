require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  before do 
    @sulfuras = [Item.new('Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80)]
    @dexterity = [Item.new(name = '+5 Dexterity Vest', sell_in = 10, quality = 20)]
    @conjured = [Item.new(name = 'Conjured Mana Cake', sell_in = 3, quality = 6)]
  end  
  describe '#update_quality' do
    it 'does not change the quality' do
    GildedRose.new(@sulfuras).update_quality
    expect(@sulfuras[0].quality).to eq 80
    end
    it 'normal items decrease the quality with the passing of the days' do
    GildedRose.new(@dexterity).update_quality
    expect(@dexterity[0].quality).to eq 19
    end
    it 'conjured items degrade twice as fast as normal items' do
    GildedRose.new(@conjured).update_quality
    expect(@conjured[0].quality).to eq 4
  end
end
end


