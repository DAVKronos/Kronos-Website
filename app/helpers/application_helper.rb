module ApplicationHelper
  include AutoHtml
  
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            :autolink => true)
            
    markdown.render(auto_html(text) {html_escape; youtube(:width => 400, :height => 250)}).html_safe
  end
  
  def getPages
      Page.all
  end
    
end
