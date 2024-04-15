class TorrentFilesController < ApplicationController
  def index
    file_path = params[:file_path]
    if file_path.present?
      @files = Dir["#{Rails.root}/public/#{file_path}/*"]
    else
      @files = Dir["#{Rails.root}/public/download/*"]
    end
  end

  def new
    @torrent_file
  end

  def download
    magnet = params[:magnet]
    DownloadJob.perform_later(magnet)
    respond_to do |format|
      format.html { redirect_to new_torrent_file_path, notice: "Successfully Created." }
    end
  end
end
