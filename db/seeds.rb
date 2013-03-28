# CATEGORIES
Category.create(name: "Grub")
Category.create(name: "Clothing")
Category.create(name: "Weapons")
Category.create(name: "Tools")
Category.create(name: "Medicine")

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
Product.create( name: "Basic Clothing", price: 75,
  description: "Plain ol' get-up for simple folk.", category_ids: ["2"])
Product.create( name: "Leather Armor", price: 250,
  description: "Good fer fendin' off 'coons and der sharp claws.", category_ids: ["2"])
Product.create( name: "Ponchos", price: 25,
  description: "It gets rainy on the trail. Better bring a poncho.", category_ids: ["2"])
Product.create( name: "Moccasins", price: 196,
  description: "Made with real Apache tears!", category_ids: ["2"])
Product.create( name: "Camoflague", price: 50,
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

#USERS
User.create(email: "demoXX+franklin@jumpstartlab.com",
  password: "password", role: :user)
User.create(email: "demoXX+jeff@jumpstartlab.com",
  password: "password", role: :admin)
User.create(email: "demoXX+steve@jumpstartlab.com",
  password: "password", role: :superuser)

#ORDERS
