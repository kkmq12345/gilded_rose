class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name != "Sulfuras, Hand of Ragnaros"
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if !item.name.include? "Conjured"
              #For normal items
              if item.sell_in >= 0 && item.quality > 0
                item.quality = item.quality - 1
              elsif item.quality > 1 
                item.quality = item.quality - 2
              else
                item.quality = 0
              end
            else
              #For Conjured Items
              if item.sell_in >= 0 && item.quality > 1
                item.quality = item.quality - 2
              elsif item.quality > 3
                item.quality = item.quality - 4
              else
                item.quality = 0
              end  
            end
          else
            #For Backstage passes
            if item.sell_in > 10 && item.quality < 50
              item.quality = item.quality + 1
            elsif item.sell_in < 11 && item.sell_in > 5 && item.quality < 49
              item.quality = item.quality + 2
            elsif item.sell_in < 6 && item.sell_in >= 0 && item.quality < 48
              item.quality = item.quality + 3
            elsif item.sell_in < 0
              item.quality = 0
            else
              item.quality = 50
            end
          end
        else
          #For Aged Brie
          if item.sell_in >= 0 && item.quality < 50
            item.quality = item.quality + 1
          elsif item.quality < 49
            item.quality = item.quality + 2
          else
            item.quality = 50
          end
        end
      end
      item.sell_in = item.sell_in - 1
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
