#Seeding products
product_names = ['Faxe Kondi','Coca Cola original',
                 'Nutramino Chokolade','Banan','Æble','Pære',
                 'Monster Energy original','Monster Safari',
                 'Faxe Kondi Booster','Coca Cola zero','Coca Vanilla','Coca Cola mint']

5_000.times do
  Product.create([{
                    name: product_names[Random.rand(product_names.count)],
                    description: 'Mmmm...',
                    price: Random.rand(100.0)
                  }])
end