module ApplicationHelper
  
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            :autolink => true, )
            
    markdown.render(h(text)).html_safe
  end
  
  def getPages
      Page.all
  end
    
end
