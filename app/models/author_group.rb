class AuthorGroup < ActiveRecord::Base
  belongs_to :paper
  has_many :authors, inverse_of: :author_group, dependent: :destroy

  def self.build_default_groups_for(paper)
    paper.author_groups = (1..3).map do |i|
      # rails clobbers ordinalize, so we have to use the aliased ordinalise
      new(name: "#{i.ordinalise.capitalize} Author")
    end
  end

  def self.ordinalized_create(params)
    papers_count = Paper.includes(:author_groups).find(params[:paper_id]).author_groups.length
    create name: "#{(papers_count + 1).ordinalise.capitalize} Author", paper_id: params[:paper_id]
  end
end