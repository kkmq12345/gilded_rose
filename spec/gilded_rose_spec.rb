require 'spec_helper'
 
describe GildedRose do

  describe "#initialize" do 
    it "Initializes items" do
      item = Item.new("Wand", 15, 10)      
      gilded_rose = GildedRose.new([item])
      expect(item.name).to eq("Wand")
    end
  end

  describe "#update_quality" do
    context "Sulfuras, Hand of Ragnaros" do

      sulfuras = Item.new("Sulfuras, Hand of Ragnaros", 20, 80)
      gilded_rose = GildedRose.new([sulfuras])
      gilded_rose.update_quality()

      it "does not change quality" do
        expect(sulfuras.quality).to eq(80)
      end

      it "decreases sell in" do
        expect(sulfuras.sell_in).to eq(19)
      end
    end

    context "Aged Brie" do

      context "sell in >= 0" do
        
        context "quality < 50" do

          aged_brie = Item.new("Aged Brie", 10, 20)
          gilded_rose = GildedRose.new([aged_brie])
          gilded_rose.update_quality()

          it "increases quality by 1" do
            expect(aged_brie.quality).to eq(21)
          end
        end

        context "quality = 50" do

          aged_brie = Item.new("Aged Brie", 10, 50)
          gilded_rose = GildedRose.new([aged_brie])
          gilded_rose.update_quality()

          it "doesn't increase quality" do
            expect(aged_brie.quality).to eq(50)
          end
        end

      end

      context "sell in < 0" do
        
        context "quality < 49" do

          aged_brie = Item.new("Aged Brie", -1, 48)
          gilded_rose = GildedRose.new([aged_brie])
          gilded_rose.update_quality()

          it "increases quality by 2" do
            expect(aged_brie.quality).to eq(50)
          end
        end

        context "quality >= 49" do

          aged_brie = Item.new("Aged Brie", -1, 49)
          gilded_rose = GildedRose.new([aged_brie])
          gilded_rose.update_quality()

          it "maintains a quality of 50" do
            expect(aged_brie.quality).to eq(50)
          end
        end
      end

      it "decreases sell in" do 

        aged_brie = Item.new("Aged Brie", 10, 20)
        gilded_rose = GildedRose.new([aged_brie])
        gilded_rose.update_quality()

        expect(aged_brie.sell_in).to eq(9)
      end
    end

    context "Backstage passes to a TAFKAL80ETC concert" do

      context "sell in > 10" do

        context "item quality < 50" do

          backstage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 20)
          gilded_rose = GildedRose.new([backstage_pass])
          gilded_rose.update_quality()

          it "increases quality by 1" do
            expect(backstage_pass.quality).to eq(21)
          end
        end

        context "item quality = 50" do

          backstage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 50)
          gilded_rose = GildedRose.new([backstage_pass])
          gilded_rose.update_quality()

          it "item quality doesn't change" do
            expect(backstage_pass.quality).to eq(50)
          end

        end
      end

      context "sell in is 6-10 days" do

        context "item quality < 49" do

          backstage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert", 7, 20)
          gilded_rose = GildedRose.new([backstage_pass])
          gilded_rose.update_quality()

          it "increases quality by 2" do
            expect(backstage_pass.quality).to eq(22)
          end
        end

        context "item quality >= 49" do

          backstage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert", 7, 49)
          gilded_rose = GildedRose.new([backstage_pass])
          gilded_rose.update_quality()

          it "sets quality to 50" do
            expect(backstage_pass.quality).to eq(50)
          end
        end
      end

      context "sell in is 0-5 days" do

        context "item quality < 48" do

          backstage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 20)
          gilded_rose = GildedRose.new([backstage_pass])
          gilded_rose.update_quality()

          it "increases quality by 3" do
            expect(backstage_pass.quality).to eq(23)
          end
        end

        context "item quality >= 48" do

          backstage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 49)
          gilded_rose = GildedRose.new([backstage_pass])
          gilded_rose.update_quality()

          it "sets quality to 50" do
            expect(backstage_pass.quality).to eq(50)
          end
        end
      end

      context "sell in < 0" do

        backstage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 49)
        gilded_rose = GildedRose.new([backstage_pass])
        gilded_rose.update_quality()

        it "sets quality to 0" do
          expect(backstage_pass.quality).to eq(0)
        end

      end

      it "decreases sell in" do

        backstage_pass = Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 49)
        gilded_rose = GildedRose.new([backstage_pass])
        gilded_rose.update_quality()

        expect(backstage_pass.sell_in).to eq(-2)
      end
    end

    context "Conjured Items" do

      context "sell in >= 0" do

        context "item quality > 1" do

          conjured_item = Item.new("Conjured", 2, 20)
          gilded_rose = GildedRose.new([conjured_item])
          gilded_rose.update_quality()

          it "decreases quality by 2" do
            expect(conjured_item.quality).to eq(18)
          end

        end

        context "item quality <= 1" do

          conjured_item = Item.new("Conjured", 2, 1)
          gilded_rose = GildedRose.new([conjured_item])
          gilded_rose.update_quality()

          it "sets quality to 0" do
            expect(conjured_item.quality).to eq(0)
          end

        end
      end

      context "sell in < 0" do

        context "item quality > 3" do

          conjured_item = Item.new("Conjured", -1, 20)
          gilded_rose = GildedRose.new([conjured_item])
          gilded_rose.update_quality()

          it "decreases quality by 4" do
            expect(conjured_item.quality).to eq(16)
          end
        end

        context "item quality <= 3" do

          conjured_item = Item.new("Conjured", -1, 2)
          gilded_rose = GildedRose.new([conjured_item])
          gilded_rose.update_quality()

          it "sets quality to 0" do
            expect(conjured_item.quality).to eq(0)
          end
        end
        
      end

      it "decreases sell in" do 

        conjured_item = Item.new("Conjured", 10, 20)
        gilded_rose = GildedRose.new([conjured_item])
        gilded_rose.update_quality()

        expect(conjured_item.sell_in).to eq(9)
      end
    end

    context "Normal Items" do

      context "sell in >= 0" do

        context "item quality > 0" do

          normal_item = Item.new("Wand", 10, 20)
          gilded_rose = GildedRose.new([normal_item])
          gilded_rose.update_quality()

          it "decreases quality by 1" do
            expect(normal_item.quality).to eq(19)
          end

        end

        context "item quality = 0" do

          normal_item = Item.new("Wand", 10, 0)
          gilded_rose = GildedRose.new([normal_item])
          gilded_rose.update_quality()

          it "sets quality to 0" do
            expect(normal_item.quality).to eq(0)
          end

        end

      end

      context "sell in < 0" do

        context "item quality > 0" do

          normal_item = Item.new("Wand", -1, 10)
          gilded_rose = GildedRose.new([normal_item])
          gilded_rose.update_quality()

          it "decreases quality by 2" do
            expect(normal_item.quality).to eq(8)
          end
        end

        context "item quality <= 1" do

          normal_item = Item.new("Wand", -1, 1)
          gilded_rose = GildedRose.new([normal_item])
          gilded_rose.update_quality()

          it "sets quality to 0 " do
            expect(normal_item.quality).to eq(0)
          end

        end

      end

      it "decreases sell in" do
        normal_item = Item.new("Wand", 10, 10)
        gilded_rose = GildedRose.new([normal_item])
        gilded_rose.update_quality()

        expect(normal_item.sell_in).to eq(9)
      end

    end

  end
end