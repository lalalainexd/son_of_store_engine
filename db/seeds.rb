# CATEGORIES
Category.create(name: "Grub")
Category.create(name: "Clothing")
Category.create(name: "Weapons")
Category.create(name: "Tools")
Category.create(name: "Medicine")
Category.create(name: "Essentials")

#GRUB
Product.create( name: "Rations", price: 24,
  description: "Good for one 'splorer.", category_ids: ["1"])
Product.create( name: "Eggs", price: 5,
  description: "Farm fresh and ready to consume.", category_ids: ["1"])
Product.create( name: "Apples", price: 19,
  description: "Great for a snack!", category_ids: ["1"])
Product.create( name: "Hardtack", price: 40,
  description: "Simple cracker for simple folk.", category_ids: ["1"])
Product.create( name: "Prickly Pear", price: 60,
  description: "Prickly on the outside, scrumptious on the inside.", category_ids: ["1"])
Product.create( name: "Bacon", price: 100,
  description: "By the slab for the whole fam!", category_ids: ["1"])
Product.create( name: "Sarsaparilla", price: 3,
  description: "Before Coke, there was sarsaparilla.", category_ids: ["1"])

#CLOTHING
Product.create( name: "Basic Tunic", price: 75,
  description: "Plain ol' get-up for simple folk.", category_ids: ["2"])
Product.create( name: "Leather Armor", price: 250,
  description: "Good fer fendin' off 'coons and der sharp claws.", category_ids: ["2"])
Product.create( name: "Ponchos", price: 25,
  description: "It gets rainy on the trail. Better bring a poncho.", category_ids: ["2"])
Product.create( name: "Moccasins", price: 196,
  description: "Made with real Apache tears!", category_ids: ["2"])
Product.create( name: "Camouflage", price: 50,
  description: "Der buffalo won't be able to see yer.", category_ids: ["2"])

#WEAPONS
Product.create( name: "Blunderbuss", price: 150,
  description: "Big ol' gun, and loads of fun!", category_ids: ["3"])
Product.create( name: "Navy Revolver", price: 500,
  description: "Great for fightin' off vermits!", category_ids: ["3"])
Product.create( name: "Volcano Pistol", price: 891,
  description: "Bandits ain't gonna be stealin' none of you'ns rations.", category_ids: ["3"])
Product.create( name: "Kentucky Rifle", price: 250,
  description: "Good fer huntin' squirrels 'n' such.", category_ids: ["3"])
Product.create( name: "Buffalo Rifle", price: 1000,
  description: "Dis here's a one-shot K.O. Big gun fer big game.", category_ids: ["3"])

#TOOLS
Product.create( name: "Stone Hunting Knife", price: 98,
  description: "Good fer fur.", category_ids: ["3", "4"])
Product.create( name: "Snake Charm", price: 25,
  description: "Never git bit by a slippery snake 'gin!", category_ids: ["4"])
Product.create( name: "Compass", price: 62,
  description: "West is where yer headed, so's ya know.", category_ids: ["4"])
Product.create( name: "Sleeping Bag", price: 3,
  description: "Regain staminer! Warm 'n' cozy.", category_ids: ["4"])
Product.create( name: "Carpenter's Tools", price: 400,
  description: "Fer fixin' up der wagon in a jiff!", category_ids: ["4"])
Product.create( name: "Divining Rod", price: 500,
  description: "Water, water, anywhere? And lots and lots to drink!", category_ids: ["4"])

#MEDICINE
Product.create( name: "Miracle Cure", price: 3000,
  description: "Completely cures anything.", category_ids: ["5"])
Product.create( name: "Antivenom", price: 15,
  description: "Heals yer snakebite in a jiff.", category_ids: ["5"])
Product.create( name: "Lemon", price: 15,
  description: "Cures scurvy and tastes great too!", category_ids: ["1", "5"])
Product.create( name: "Medicine bag", price: 1000,
  description: "All yer fixin's in one handy sack.", category_ids: ["5"])
Product.create( name: "Cod Liver Oil", price: 10,
  description: "Tastes like dung. But good fer yer body.", category_ids: ["5"])

#ESSENTIALS
Product.create( name: "Oxen", price: 4000,
  description: "Strong, durable, and more MPG than yer SUV.", category_ids: ["6"])
Product.create( name: "Guide", price: 15000,
  description: "Well hey there, partner! I'm here to help.", category_ids: ["6"])
Product.create( name: "Wagon", price: 15000,
  description: "Made of wood, so you know it's good.", category_ids: ["6"])
Product.create( name: "Tombstone", price: 1000,
  description: "Cause one person always gets off'd on the Oregon Trail. Always.", category_ids: ["6"])

#RETIRED
Product.create( name: "Peacoat", price: 3000,
  description: "Classy coat for the classy gent.", category_ids: ["1"], retired: true)

#USERS
User.create(full_name: "Franklin Webber", email: "demoXX+franklin@jumpstartlab.com",
  password: "password", role: :user, display_name: nil)
User.create(full_name: "Jeff", email: "demoXX+jeff@jumpstartlab.com",
  password: "password", role: :admin, display_name: "j3")
User.create(full_name: "Steve Klabnik", email: "demoXX+steve@jumpstartlab.com",
  password: "password", role: :superuser, display_name: "SkrilleX")
User.create(full_name: "Katrina Owen", email: "demoXX+katrina@jumpstartlab.com",
  password: "password", role: :user, display_name: "Ree-na")

#LINE ITEMS
##1
LineItem.create(product_id: 1, cart_id: nil,
  order_id: 1, quantity: 3, price: 24)
LineItem.create(product_id: 2, cart_id: nil,
  order_id: 1, quantity: 4, price: 200)
LineItem.create(product_id: 3, cart_id: nil,
  order_id: 1, quantity: 5, price: 500)
##2
LineItem.create(product_id: 25, cart_id: nil,
  order_id: 2, quantity: 1, price: 300)
LineItem.create(product_id: 26, cart_id: nil,
  order_id: 2, quantity: 15, price: 205)
LineItem.create(product_id: 6, cart_id: nil,
  order_id: 2, quantity: 4, price: 1000)
##3
LineItem.create(product_id: 7, cart_id: nil,
  order_id: 3, quantity: 7, price: 600)
LineItem.create(product_id: 10, cart_id: nil,
  order_id: 3, quantity: 1, price: 5)
##4
LineItem.create(product_id: 1, cart_id: nil,
  order_id: 4, quantity: 1, price: 377)
LineItem.create(product_id: 15, cart_id: nil,
  order_id: 4, quantity: 1, price: 111)
##5
LineItem.create(product_id: 13, cart_id: nil,
  order_id: 5, quantity: 1, price: 800)
##6
LineItem.create(product_id: 12, cart_id: nil,
  order_id: 6, quantity: 6, price: 123)
LineItem.create(product_id: 11, cart_id: nil,
  order_id: 6, quantity: 2, price: 111)
LineItem.create(product_id: 17, cart_id: nil,
  order_id: 6, quantity: 2, price: 89)
##7
LineItem.create(product_id: 9, cart_id: nil,
  order_id: 7, quantity: 2, price: 4)
##8
LineItem.create(product_id: 8, cart_id: nil,
  order_id: 8, quantity: 20, price: 800)
##9
LineItem.create(product_id: 31, cart_id: nil,
  order_id: 9, quantity: 1, price: 444)
LineItem.create(product_id: 32, cart_id: nil,
  order_id: 9, quantity: 2, price: 1230)
LineItem.create(product_id: 33, cart_id: nil,
  order_id: 9, quantity: 3, price: 500)
LineItem.create(product_id: 10, cart_id: nil,
  order_id: 9, quantity: 4, price: 110)
##10
LineItem.create(product_id: 24, cart_id: nil,
  order_id: 10, quantity: 5, price: 80)
LineItem.create(product_id: 23, cart_id: nil,
  order_id: 10, quantity: 6, price: 10)

#ORDERS
Order.create(status: "pending", user_id: 1, total_cost: 3372)
Order.create(status: "pending", user_id: 4, total_cost: 7375)
Order.create(status: "cancelled", user_id: 1, total_cost: 4205)
Order.create(status: "cancelled", user_id: 1, total_cost: 488)
Order.create(status: "paid", user_id: 4, total_cost: 800)
Order.create(status: "paid", user_id: 1, total_cost: 1138)
Order.create(status: "shipped", user_id: 4, total_cost: 8)
Order.create(status: "shipped", user_id: 4, total_cost: 16000)
Order.create(status: "returned", user_id: 1, total_cost: 4844)
Order.create(status: "returned", user_id: 4, total_cost: 460)