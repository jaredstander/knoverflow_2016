class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :content
      t.references :user
      t.references :question
      t.integer :vote_count, default: 0
      t.timestamps
    end
  end
end
