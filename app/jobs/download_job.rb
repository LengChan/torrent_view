class DownloadJob < ApplicationJob
  queue_as :default

  def perform(magnet)
    magnet = "magnet:?xt=urn:btih:" + magnet.gsub("magnet:?xt=urn:btih:", "")
    Dir.chdir("#{Rails.root}/public/download") do
      # 执行ls命令
      system("/home/ubuntu/go/bin/torrent download #{magnet}")
    end
  end
end