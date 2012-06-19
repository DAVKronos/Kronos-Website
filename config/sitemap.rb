Sitemap::Generator.instance.load :host => "kronos.nl" do
  path :root, :priority => 1
  Page.all.each do |page|
    path page.pagetag
  end
end