class AddAttributesToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :message, :string
    add_reference :tweets, :user, type: :integer, foreign_key: true
  end
end
