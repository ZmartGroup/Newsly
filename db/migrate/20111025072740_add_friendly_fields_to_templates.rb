class AddFriendlyFieldsToTemplates < ActiveRecord::Migration
  def change
  	add_column :newsly_templates, 	:friendly_name, :string
  	add_column :newsly_templates, 	:description,		:string
  end
end
