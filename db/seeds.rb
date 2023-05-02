#Seeding products
product_names = ['Faxe Kondi','Coca Cola',
                 'Nutramino Chokolade','Banan','Æble','Pære',
                 'Monster Energy original','Monster Safari',
                 'Faxe Kondi Booster','Coca Zero','Coca Vanilla','Coca Mint']

5_000.times do
  Product.create([{ name: product_names[Random.rand(product_names.count)] }])
end