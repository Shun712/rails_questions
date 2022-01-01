class ChangeQuestionsContentLimit500 < ActiveRecord::Migration[5.2]
  def change
    def up 
      change_column :questions, :content, :text, limit: 500
    end 

    def down
      change_column :questions, :content, :text
    end 
  end
end
