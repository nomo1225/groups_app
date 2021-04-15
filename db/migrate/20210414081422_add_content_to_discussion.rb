class AddContentToDiscussion < ActiveRecord::Migration[5.2]
  def change
    add_column :discussions, :content, :string
  end
end
