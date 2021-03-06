class CreateFoJournals < ActiveRecord::Migration[5.2]
  def change
      create_table "fo_journals", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
        t.integer :journal_id
			  t.string :status , limit: 25, null: true
        t.string :type, limit:1, null:true
        t.timestamps null: false
      end
    end
end
