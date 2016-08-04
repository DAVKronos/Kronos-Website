module ApplicationHelper
  include AutoHtml
  
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            :autolink => true)
            
    markdown.render(auto_html(text) {html_escape; youtube(:width => "100%", :height => 250)}).html_safe
  end

  def page_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       :autolink => true)

    markdown.render(text).html_safe
  end
  
  def getPages(menu_item)
      Page.where('menu = ?', menu_item)
  end

  def getHighlight
      Page.where(highlight: true).first
  end

  def getHighlights
    Page.where(highlight: true).all
  end
end
