class CreateNewslyTemplates < ActiveRecord::Migration
  def change
    create_table :newsly_templates do |t|
      t.string 	:name
      t.string	:template_type
      t.string	:subject
      t.text 		:body

      t.timestamps
    end
  end
end
