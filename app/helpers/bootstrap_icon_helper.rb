module BootstrapIconHelper
  def icon_link_to(path, opts = {}, link_opts = {})
    classes = []
    [:icon, :blank].each do |klass|
      if k = opts.delete(klass)
        classes << "#{klass}-#{k}"
      end
    end
    classes << "enlarge" if opts.delete(:enlarge)
    opts[:class] ||= ""
    opts[:class] << " " << classes.join(" ")
    link_to content_tag(:i, "", opts), path, link_opts
  end

  def icon(icon)
    class_style = "glyphicon glyphicon-" << icon
    content_tag(:span,'',:class=>class_style)
  end

  def icon_button(path, icon, str, link_opts = {})
    link_opts[:class] = "btn btn-default" if link_opts[:class].nil?
    link_to icon(icon) << " " << str, path, link_opts  
	end

end
