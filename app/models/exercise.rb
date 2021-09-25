class Exercise < ApplicationRecord


    def update_embed_url(url)
        re = /(https:.*\/embed)/
        re.match(url)
        embed_url = $1
        self.url = embed_url
        self.save!
    end
end
