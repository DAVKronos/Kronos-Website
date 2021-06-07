module ApplicationHelper
  
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
            :autolink => true)
            
    markdown.render(text).html_safe
  end

  def page_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                       :autolink => true)

    markdown.render(text).html_safe
  end
  
  def getPages(menu_item)
      Page.where('menu = ?', menu_item).order(sort_order: :asc)
  end

  def getHighlight
      Page.where(highlight: true).first
  end

  def getHighlights
    Page.where(highlight: true).order(sort_order: :asc)
  end
end
