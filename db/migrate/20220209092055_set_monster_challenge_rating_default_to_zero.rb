class SetMonsterChallengeRatingDefaultToZero < ActiveRecord::Migration[6.1]
  def change
    change_column :monsters, :challenge_rating, :string, default: '0'
  end
end
