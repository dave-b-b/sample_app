class RemovePassswordDigestFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :passsword_digest, :string
  end
end
