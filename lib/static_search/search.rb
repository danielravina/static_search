class StaticSearch::Search
  def self.find_content(q)
    StaticContent.where("content like %?%", q);
  end
end