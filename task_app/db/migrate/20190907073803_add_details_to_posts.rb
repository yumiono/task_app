class AddDetailsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :due_date, :datetime
    add_column :posts, :executor, :string
  end
end
