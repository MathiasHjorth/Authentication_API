#Seeding products
product_names = ['Faxe Kondi','Coca Cola original',
                 'Nutramino Chokolade','Banan','Æble','Pære',
                 'Monster Energy original','Monster Safari',
                 'Faxe Kondi Booster','Coca Cola zero','Coca Vanilla','Coca Cola mint']

#
# 5_000.times do
#   Product.create([{
#                     name: product_names[Random.rand(product_names.count)],
#                     description: 'Mmmm...',
#                     price: Random.rand(100.0)
#                   }])
# end

100.times do
  order_number = Time.current.strftime('%M%S%L').to_i
  user_id_gen = Random.rand(21..27)
  Random.rand(1..10).times do
    Order.create([{user_id: user_id_gen, product_id: Random.rand(1..5000),price_at_checkout: 50.00, product_quantity: Random.rand(1..24),order_number:"1-2-#{order_number}"}])
  end
end