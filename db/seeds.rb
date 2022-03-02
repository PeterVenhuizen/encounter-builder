# Create some parties and players
candlekeep = Party.create({
  name: 'Candlekeep by LED-light',
  players_attributes: [
    { name: 'Barbara', level: 1 },
    { name: 'Luis', level: 1 },
    { name: 'Stefan', level: 1 },
    { name: 'PNF', level: 1 }
  ]
})

team_rocket = Party.create({
  name: 'Team Rocket',
  players_attributes: [
    { name: 'Jessie', level: 1 },
    { name: 'James', level: 1 },
    { name: 'Meowth', level: 1 }
  ]
})

# Create some monsters
animated_books = Monster.create({
  name: 'Swarm of Animated Books',
  size: 'Medium',
  species: 'Construct',
  alignment: 'unaligned',
  armor_class: '12 (natural armor)',
  hit_points: 22,
  hit_dice: '4d8 + 4',
  speed: {"fly"=>"30", "swim"=>"0", "walk"=>"0", "climb"=>"0", "burrow"=>"0"},
  ability_scores: {"constitution"=>"12", "intelligence"=>"1", "wisdom"=>"10", "charisma"=>"1", "strength"=>"10", "dexterity"=>"13"},
  languages: '',
  challenge_rating: '1/4',
  xp: 50,
  proficiency_bonus: 2
})

broom = Monster.create({
  name: 'Animated Broom',
  size: 'Small',
  species: 'Construct',
  alignment: 'unaligned',
  armor_class: '15 (natural armor)',
  hit_points: 17,
  hit_dice: '5d6',
  speed: {"fly"=>"50", "swim"=>"0", "walk"=>"0", "climb"=>"0", "burrow"=>"0"},
  ability_scores: {"strength"=>"10", "dexterity"=>"17", "constitution"=>"10", "intelligence"=>"1", "wisdom"=>"5", "charisma"=>"1"},
  languages: '',
  challenge_rating: '1/4',
  xp: 50,
  proficiency_bonus: 2
})

chained_library = Monster.create({
  name: 'Animated Chained Library',
  size: 'Large',
  species: 'Construct',
  alignment: 'unaligned',
  armor_class: '14 (natural armor)',
  hit_points: 45,
  hit_dice: '6d10 + 12',
  speed: {"fly"=>"0", "swim"=>"0", "walk"=>"10", "climb"=>"0", "burrow"=>"0"},
  ability_scores: {"strength"=>"15", "dexterity"=>"8", "constitution"=>"14", "intelligence"=>"1", "wisdom"=>"5", "charisma"=>"1"},
  languages: '',
  challenge_rating: '1',
  xp: 200,
  proficiency_bonus: 2
})

bandit = Monster.create({
  name: 'Bandit',
  size: 'Medium',
  species: 'Humanoid',
  alignment: 'any non-lawful alignment',
  armor_class: 12,
  hit_points: 11,
  hit_dice: '2d8',
  speed: {"fly"=>"0", "swim"=>"0", "walk"=>"30", "climb"=>"0", "burrow"=>"0"},
  ability_scores: {"wisdom"=>"10", "charisma"=>"10", "strength"=>"11", "dexterity"=>"12", "constitution"=>"12", "intelligence"=>"10"},
  languages: 'any one language (usually Common)',
  challenge_rating: '1/4',
  xp: 25,
  proficiency_bonus: 2
})
cat = Monster.create({
  name: 'Cat',
  size: 'Tiny',
  species: 'Beast',
  alignment: 'unaligned',
  armor_class: 12,
  hit_points: 2,
  hit_dice: '1d4',
  speed: {"fly"=>"0", "swim"=>"0", "walk"=>"40", "climb"=>"30", "burrow"=>"0"},
  ability_scores: {"wisdom"=>"12", "charisma"=>"7", "strength"=>"3", "dexterity"=>"15", "constitution"=>"10", "intelligence"=>"3"},
  languages: '',
  challenge_rating: '0',
  xp: 10,
  proficiency_bonus: 2
})
quasit = Monster.create({
  name: 'Quasit',
  size: 'Tiny',
  species: 'Fiend',
  alignment: 'chaotic evil',
  armor_class: '13',
  hit_points: 7,
  hit_dice: '3d4',
  speed: {"fly"=>"0", "swim"=>"0", "walk"=>"40", "climb"=>"0", "burrow"=>"0"},
  ability_scores: {"strength"=>"5", "dexterity"=>"17", "constitution"=>"10", "intelligence"=>"7", "wisdom"=>"10", "charisma"=>"10"},
  languages: 'Abyssal, Common',
  challenge_rating: '1',
  xp: 200,
  proficiency_bonus: 2
})

# Add a standard encounter
team_rocket.encounters.create({
  name: 'Two bandits and a cat',
  description: 'Lorem catsum',
  fates_attributes: [
    { monster_id: bandit.id, group_size: 2 },
    { monster_id: cat.id }
  ]
})

candlekeep.encounters.create({
  name: 'M3. Library',
  description: ">Tall shelves filled with books line the walls of this room. Two more shelves run through the middle of the room with a ten-foot-wide aisle between them. Several stacks of books are piled high throughout the room. There are small reading desks with cozy scarlet chairs in the corners.

  The shelves contain books on Fistandia's favorite subjects: arcana, natural science, religion, astrology, and planar travel, as well as volumes of poetry, mythology, and folk tales.
  
  __Book Attack.__ One of the heaps of books is a *swarm of animated books*. As the characters move through the room, the swarm knocks one of the 10-foot-wide freestanding sections of bookshelf over onto the characters. Any creatures in the affected area must succeed on a DC 15 Dexterity saving throw or be knocked prone and restrained by the fellen shelf. A restrained creature can use an action to make a DC 13 Strength (Athletics) check. On a success, it frees itself. Restrained creatures are also freed if the shelf is lifted with a successful DC 15 Strength (Athletics) check.
  
  __Treasure.__ Sitting on the reading deks is a jeweled letter opener worth 20 gp.
  
  __Puzzle Book.__ The puzzle book with the letter R on its spine is on one of the shelves. Any character who has a passive Wisdom (Perception) score of 12 or higher notices the book. A thorough search of the shelf also yields the book.
  ",
  fates_attributes: [
    { monster_id: animated_books.id }
  ]
})

candlekeep.encounters.create({
  name: 'M13. The Chained Library',
  description: ">This room is bare except for a bookshelf covered in chains against one wall, a plain wooden bench, and a reading desk built into the shelves. A book with the bust of a mage on its cover sits on the desk.
  The three shelves are filled with books bound in iron covers, which are attached to chains that secure them to the shelves-a chained library. The reading desk is used to support the chained books while they are being read. This chained library has been enchanted to be jealously possesive of its contents. It attacks any creature that comes within its reach.
  
  Fistandia's most treasured knowledge is kept here. There are rare tomes on the sciences, arcana, and alchemy, as well as books about planar lore and the summoning of fantastic creatures. All the books are firmly affixed to the shelves by enchanted chains and can't be freed without being destroyed. 
  
  __Treasure.__ If the characters defeat the animated chained library, one of its books breaks free with a length of chain still attached and functions as a _+1 flail_. The books is entitled _Martial Attack Techniques_.
  
  __Puzzle Book.__ The book on the reading desk is the puzzle book with the letter L on its spine.",
  fates_attributes: [
    { monster_id: chained_library.id }
  ]
})

candlekeep.encounters.create({
  name: 'M18. Summoning Room',
  description: "M18. Summoning room
  >This dark, stone-walled room contains only a few objects. A five-foot-diameter circle of intricate runes covers the floor. There's an empty wooden bookstand opposite the door and bronze braziers at the other three cardinal points of the circle. Whatever material they contained has long ago burned to cinders, but the room still smells of charcoal and sulfur. Sitting next to the bookstand is a warty toad.
  
  This is the room where Fistandia summoned the imp that would become the figurine found by Matreous. The current resident of the room is a *quasit* in toad form. It waits for a creature to approach and then attacks.",
  fates_attributes: [
    { monster_id: quasit.id }
  ]
})