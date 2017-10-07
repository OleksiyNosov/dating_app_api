class Combinator
  def initialize first_array, second_array
    @product = first_array.product second_array
  end

  def delete_pair_at id
    @product.delete_at id
  end

  def delete_random_pair
    delete_pair_at rand(@product.length)
  end
end