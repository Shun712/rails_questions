class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :title, limit: 30, null: false
      t.text :content
      t.boolean :solved_check, null: false

      t.timestamps
    end
  end
end
