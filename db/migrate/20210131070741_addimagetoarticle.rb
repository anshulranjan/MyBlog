class Addimagetoarticle < ActiveRecord::Migration[6.1]
  def change
    def self.up
      add_attachment :articles, :image
    end

    def self.down
      remove_attachment :articles, :image
    end
  end
end
