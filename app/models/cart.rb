class Cart
  attr_accessor :cart_data
  def initialize(cart_data)
    @cart_data = cart_data || Hash.new(0)
  end

  def items
    self.cart_data.map do |item_id, quantity|
      item = Item.find(item_id)
      CartItem.new(item, quantity)
    end
  end

  def add_item(item_id)
    item = Item.find(item_id)
    self.cart_data[item.id.to_s] = self.cart_data[item.id.to_s].to_i + 1
  end

end