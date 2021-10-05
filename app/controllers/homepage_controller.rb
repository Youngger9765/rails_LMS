class HomepageController < ApplicationController

  def index
    all_topics_code = 'cb7bc45b49084312b64777d1730b887c'

    headers = {
      :Authorization => ENV['notion_secet'],
      "Content-Type": "application/json",
      "Notion-Version": "2021-05-13"
    }
    
    resp = HTTParty.get(
      "https://api.notion.com/v1/blocks/" + all_topics_code + "/children", 
      :headers => headers
    )

    status_code = resp.code
    @results = resp.parsed_response['results']
    
  end

  def topics
    page_code = params['page_code']

    headers = {
      :Authorization => ENV['notion_secet'],
      "Content-Type": "application/json",
      "Notion-Version": "2021-05-13"
    }
    
    resp = HTTParty.get(
      "https://api.notion.com/v1/blocks/" + page_code + "/children", 
      :headers => headers
    )

    status_code = resp.code
    @results = resp.parsed_response['results']
  end

  def contents
    page_code = params['page_code']

    headers = {
      :Authorization => ENV['notion_secet'],
      "Content-Type": "application/json",
      "Notion-Version": "2021-05-13"
    }
    
    resp = HTTParty.post(
      "https://api.notion.com/v1/databases/" + page_code + "/query", 
      :headers => headers
    )

    status_code = resp.code
    @results = resp.parsed_response['results']
    @content_list = []

    for result in @results
      @type = result['properties']['Type']['multi_select'][0]['name']
      @title = result['properties']['Name']['title'][0]['plain_text']
      @position = result['properties']['position']['number']

      if @type == "exercise"
        page_id = result['properties']['Exercise_id']['relation'][0]['id']
      elsif @type == "video"
        page_id = result['properties']['Video_id']['relation'][0]['id']
      end

      _headers = {
        :Authorization => ENV['notion_secet'],
        "Content-Type": "application/json",
        "Notion-Version": "2021-05-13"
      }
      
      _resp = HTTParty.get(
        "https://api.notion.com/v1/pages/" + page_id, 
        :headers => _headers
      )

      if @type == "exercise"
        @content_id = _resp.parsed_response['properties']['exercise_id']['title'][0]['text']['content']
      elsif @type == "video"
        @content_id = _resp.parsed_response['properties']['youtube_id']['title'][0]['text']['content']
      end

      content = {
        :type => @type,
        :title => @title,
        :content_id => @content_id,
        :position => @position
      }
      
      
      @content_list << content
    end
    @content_list = @content_list.sort_by { |item| item[:position] }
  end
    
end
