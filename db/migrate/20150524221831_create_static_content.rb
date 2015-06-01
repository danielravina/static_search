class CreateStaticContent < ActiveRecord::Migration
  def change
    create_table :static_content do |t|
      t.text :content
      t.string :title
      t.timestamps
    end
  end
end
