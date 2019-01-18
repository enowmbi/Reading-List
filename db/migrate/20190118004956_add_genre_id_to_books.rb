class AddGenreIdToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column('books','genre_id',:integer)
  end
end
