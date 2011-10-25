class AddTemplateColumn < ActiveRecord::Migration
  def change
  	add_column :newsly_templates, 	:internal_template, :text
		add_column :newsly_newsletters, :internal_template, :text  	
	end
end
