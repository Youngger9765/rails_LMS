class HomepageController < ApplicationController

  def index
    headers = {
      :Authorization => "Bearer secret_xxxxxxx",
      "Content-Type": "application/json",
      "Notion-Version": "2021-05-13"
    }
    
    resp = HTTParty.get(
      "https://api.notion.com/v1/pages/44179ba7497146e69e064c82d10ebf10", 
      :headers => headers
    )
  end
    

end
