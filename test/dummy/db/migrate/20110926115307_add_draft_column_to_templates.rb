class AddDraftColumnToTemplates < ActiveRecord::Migration
  def change
  	add_column :newsly_templates, :draft, :boolean
  	add_column :newsly_templates, :parent_id, :integer
  end
end
