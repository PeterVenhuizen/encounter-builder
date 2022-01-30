json.extract! monster, :id, :name, :size, :species, :armor_class, :hit_points, :challenge_rating, :created_at, :updated_at
json.url monster_url(monster, format: :json)
