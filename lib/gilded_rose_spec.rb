require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  before do 
    @sulfuras = Item.new('Sulfuras, Hand of Ragnaros', sell_in = 0, quality = 80)
    @dexterity = Item.new(name = '+5 Dexterity Vest', sell_in = 10, quality = 20)
    @conjured = Item.new(name = 'Conjured Mana Cake', sell_in = 3, quality = 6)
    @backstage_1 = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 3, quality = 55)
    @backstage_2 = Item.new(name = 'Backstage passes to a TAFKAL80ETC concert', sell_in = 10, quality = 46)
    @Aged_brie = Item.new(name = 'Aged Brie', sell_in = 2, quality = 0)
    @gilded_rose = GildedRose.new([@sulfuras,@dexterity,@conjured,@backstage_1,@backstage_2,@Aged_brie])
    @gilded_rose.update_quality
  end  
  describe '#update_quality' do
      it 'Sulfuras: does not change the quality when time has passed' do
        expect(@gilded_rose.inventory[0].quality).to eq 80
      end
      it 'Sulfuras: does not sell in' do
        expect(@gilded_rose.inventory[0].sell_in).to eq -1
      end
      it 'Normal items: their quality decreases with the passing of the days' do
        expect(@gilded_rose.inventory[1].quality).to eq 19
      end
      it 'Conjured items: degrades twice as fast as normal items' do
        expect(@gilded_rose.inventory[2].quality).to eq 4
      end
      it 'Backstage passes: quality cannot exceed over 50' do
        expect(@gilded_rose.inventory[3].quality).to eq 50
      end
      it 'Backstage passes: increases quality +2  when the sell_in is  < 11' do
        expect(@gilded_rose.inventory[4].quality).to eq 48
      end
      it 'Aged Brie: always increases its quality no matter the sell in value' do
        expect(@gilded_rose.inventory[5].quality).to eq 1
      end
  end
end


