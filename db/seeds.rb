# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#GRUB
Product.create( name: "Rations", price: 24,
  description: "")
Product.create( name: "Farm Rations", price: 20,
  description: "")
Product.create( name: "War Rations", price: 40,
  description: "")
Product.create( name: "Eggs", price: 5,
  description: "")
Product.create( name: "Apples", price: 19,
  description: "")
Product.create( name: "Hardtack", price: 40,
  description: "")
Product.create( name: "Chicken Soup", price: 50,
  description: "")
Product.create( name: "Saguaro Fruit", price: 50,
  description: "")
Product.create( name: "Prickly Pear", price: 60,
  description: "")
Product.create( name: "Root Beer", price: 63,
  description: "")
Product.create( name: "Canteen", price: 50,
  description: "")
Product.create( name: "Flour", price: 80,
  description: "")
Product.create( name: "Tea", price: 80,
  description: "")
Product.create( name: "Bacon", price: 100,
  description: "")
Product.create( name: "Sarsaparilla", price: 3,
  description: "")

#CLOTHING
Product.create( name: "Basic Clothing", price: 75,
  description: "Plain ol' get-up for simple folk.")
Product.create( name: "Leather Armor", price: 250,
  description: "Good fer fendin' off 'coons and der sharp claws.")
Product.create( name: "Ponchos", price: 25,
  description: "It gets rainy on the trail. Better bring a poncho.")
Product.create( name: "Moccasins", price: 196,
  description: "Made with real Apache tears!")
Product.create( name: "Camoflague", price: 50,
  description: "Der buffalo won't be able to see yer.")

#WEAPONS
Product.create( name: "Blunderbuss", price: 150,
  description: "Big ol' gun, and loads of fun!")
Product.create( name: "Navy Revolver", price: 500,
  description: "Great for fightin' off vermits!")
Product.create( name: "Volcano Pistol", price: 891,
  description: "Bandits ain't gonna be stealin' none of you'ns rations.")
Product.create( name: "Kentucky Rifle", price: 250,
  description: "Good fer huntin' squirrels 'n' such.")
Product.create( name: "Buffalo Rifle", price: 1000,
  description: "Dis here's a one-shot K.O. Big gun fer big game.")

#TOOLS
Product.create( name: "Stone Hunting Knife", price: 98,
  description: "Good fer fur.")
Product.create( name: "Snake Charm", price: 25,
  description: "Never git bit by a slippery snake 'gin!")
Product.create( name: "Compass", price: 62,
  description: "West is where yer headed, so's ya know.")
Product.create( name: "Sleeping Bag", price: 3,
  description: "Regain staminer! Warm 'n' cozy.")
Product.create( name: "Carpenter's Tools", price: 400,
  description: "Fer fixin' up der wagon in a jiff!")

#MEDICINE
Product.create( name: "Miracle Cure", price: 3000,
  description: "Completely cures anything.")
Product.create( name: "Antivenom", price: 15,
  description: "Heals yer snakebite in a jiff.")
Product.create( name: "Lemon", price: 15,
  description: "Cures scurvy and tastes great too!")
Product.create( name: "Medicine bag", price: 1000,
  description: "All yer fixin's in one handy sack.")
Product.create( name: "Cod Liver Oil", price: 10,
  description: "Tastes like dung. But good fer yer body.")

# CATEGORIES
Category.create(name: "Grub")
Category.create(name: "Clothing")
Category.create(name: "Weapons")
Category.create(name: "Tools")
Category.create(name: "Medicine")

#USERS
User.create(email: "demoXX+franklin@jumpstartlab.com",
  password: "password", role: :user)
User.create(email: "demoXX+jeff@jumpstartlab.com",
  password: "password", role: :admin)
User.create(email: "demoXX+steve@jumpstartlab.com",
  password: "password", role: :superuser)

#Orders
