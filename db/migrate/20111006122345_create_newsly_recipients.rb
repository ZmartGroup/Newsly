class CreateNewslyRecipients < ActiveRecord::Migration
  def change
    create_table :newsly_recipients do |t|
    	t.newsletter_id :integer
    	t.email					:string
      t.timestamps
    end
  end
end
