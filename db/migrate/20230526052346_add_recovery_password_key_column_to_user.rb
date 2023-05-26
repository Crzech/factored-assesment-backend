class AddRecoveryPasswordKeyColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :recovery_password_key, :string
  end
end
