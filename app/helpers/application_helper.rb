module ApplicationHelper
  include AutoHtml
  
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            :autolink => true)
            
    markdown.render(auto_html(text) {html_escape; youtube(:width => "100%", :height => 250)}).html_safe
  end

  def page_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       :autolink => false)

    markdown.render(text).html_safe
  end
  
  def getPages
      Page.all
  end
    
end
