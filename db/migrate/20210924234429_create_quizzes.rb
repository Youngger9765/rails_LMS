class CreateQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzes do |t|
      t.string :name, :index => true
      t.string :cover_range, :index => true
      t.string :text
      t.string :text_url
      t.string :answers
      t.string :correct_answer
      t.timestamps
    end
  end
end
