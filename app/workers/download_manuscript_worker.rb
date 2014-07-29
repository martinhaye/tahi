class DownloadManuscriptWorker
  include Sidekiq::Worker

  def perform(manuscript_id, url)
    manuscript = Manuscript.find(manuscript_id)
    manuscript.source.download!(url)
    manuscript.status = "done"
    manuscript.save
    manuscript.paper.update OxgarageParser.new(open(manuscript.source.file.url)).to_hash
  end
end