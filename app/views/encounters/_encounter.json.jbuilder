json.extract! monster, :id, :name, :description, :monsters, :created_at, :updated_at
json.url monster_url(monster, format: :json)