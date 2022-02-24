# Create some parties and players
solo = Party.create({
  name: 'Solo',
  players_attributes: [
    { name: 'Han', level: 3 }
  ]
})

duo = Party.create({
  name: 'Duo',
  players_attributes: [
    { name: 'Banjo', level: 1 },
    { name: 'Kazooie', level: 1 }
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

# Add a standard encounter
team_rocket.encounters.create({
  name: 'Two bandits and a cat',
  description: 'Lorem catsum',
  fates_attributes: [
    { monster_id: bandit.id, group_size: 2 },
    { monster_id: cat.id }
  ]
})