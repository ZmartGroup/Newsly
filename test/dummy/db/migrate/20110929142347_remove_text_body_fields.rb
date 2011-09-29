class RemoveTextBodyFields < ActiveRecord::Migration
  def change
		remove_column :newsly_templates, 	:text_body
  	remove_column :newsly_newsletters, :text_body
	end
end
