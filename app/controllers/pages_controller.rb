class PagesController < ApplicationController
  before_filter :authenticate, :only => [:admin]
  def home
  end

  def contact
  end
  
  def about
  end
  
  def information
  end

end
