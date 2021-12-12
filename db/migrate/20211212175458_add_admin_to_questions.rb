class AddAdminToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :admin, :boolean, default: false, null: false
  end
end
