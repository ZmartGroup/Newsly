class AddDraftColumnToTemplates < ActiveRecord::Migration
  def change
  	add_column :newsly_templates, :draft, :boolean
  end
end
