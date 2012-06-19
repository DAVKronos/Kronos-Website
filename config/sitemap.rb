Sitemap::Generator.instance.load :host => "kronos.nl" do
  path :root, :priority => 1
  resources :pages
end