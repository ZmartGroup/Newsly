class AddFieldsToNewsletter < ActiveRecord::Migration
  def change
  	add_column :newsly_newsletters,	:batch_sent, :integer
  end
end
