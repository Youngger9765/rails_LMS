class AddYoutubeInfoToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :is_available,      :boolean
    add_column :videos, :provider,          :string
    add_column :videos, :video_id,          :string
    add_column :videos, :title,             :string
    add_column :videos, :duration,          :integer
    add_column :videos, :thumbnail_small,   :text
    add_column :videos, :thumbnail_medium,  :text
    add_column :videos, :thumbnail_large,   :text
    add_column :videos, :embed_url,         :text
    add_column :videos, :embed_code,        :text
  end
end
