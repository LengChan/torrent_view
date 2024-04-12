class PagesController < ApplicationController
  def home
  end

  def detail
  end

  def files
    file_path = params[:file_path]
    if file_path.present?
      @files = Dir["#{Rails.root}/public/download/#{file_path}/*"]
    else
      @files = Dir["#{Rails.root}/public/download/*"]
    end
  end

end
