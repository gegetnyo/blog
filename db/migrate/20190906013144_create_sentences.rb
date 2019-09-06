class CreateSentences < ActiveRecord::Migration[5.2]
  def change
    create_table :sentences do |t|
      t.integer :user_id
      t.text :text
      t.timestamps
    end
  end
end
