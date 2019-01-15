class AddFinishedAtToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :finished_at, :datetime
  end
end
