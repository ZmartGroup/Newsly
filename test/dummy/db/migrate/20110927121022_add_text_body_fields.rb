class AddTextBodyFields < ActiveRecord::Migration
  def change
  	add_column :newsly_templates, 	:text_body, :text
  	add_column :newsly_newsletters, :text_body, :text	
	end
end
