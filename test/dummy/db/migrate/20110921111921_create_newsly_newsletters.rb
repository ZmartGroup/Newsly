class CreateNewslyNewsletters < ActiveRecord::Migration
  def change
    create_table :newsly_newsletters do |t|
      t.string 	:title
      t.text 		:body
      t.boolean :sent

      t.timestamps
    end
  end
end
