class TorrentFilesController < ApplicationController
  def index
    file_path = params[:file_path]
    if file_path.present?
      @files = Dir["#{file_path}/*"]
    else
      @files = Dir["/Users/zuoganghua/projects/*"]
    end
  end

  def show_file
    file_path = params[:file_path].to_s

    # 确保文件存在
    unless File.exist?(file_path)
      return render plain: "Video not found", status: :not_found
    end

    response.headers['Content-Type'] = 'video/mp4'
    response.headers['Content-Disposition'] = "inline; filename=\"#{file_path}\""

    # 发送文件内容
    send_file file_path, type: 'video/mp4', disposition: 'inline'
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
