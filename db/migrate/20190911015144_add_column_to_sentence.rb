class AddColumnToSentence < ActiveRecord::Migration[5.2]
  def change
    add_column :sentences, :start_time, :datetime
  end
end
