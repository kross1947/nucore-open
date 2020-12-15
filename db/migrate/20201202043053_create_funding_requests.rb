class CreateFundingRequests < ActiveRecord::Migration[5.2]
  def change
      create_table "funding_requests", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
        t.integer "account_id" , null: false
			  t.string "request_type", limit: 50, null: false
			  t.string "status" , limit: 50, null: false
        t.decimal "debit_amt",  precision: 10, scale: 2 , null: true
        t.decimal "credit_amt",  precision: 10, scale: 2 , null: true
        t.integer "created_by", null: false
			  t.datetime "created_at", null: false
        t.integer "updated_by", null:true
        t.datetime "updated_at", null:true
      end
    end
end
