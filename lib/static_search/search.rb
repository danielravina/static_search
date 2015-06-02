class StaticSearch::Search
  @TRUNCATION = 220

  def self.find_content(q)
    return [] unless q.present?
    result = StaticContent.where("LOWER(content) like ? OR LOWER(title) like ?", "% #{q} %", "%#{q}%");
    return result.map(&:as_json)
  end

  def self.truncate_body content, q
    content = \
      if content.include? q

        index = content.downcase.index(q.downcase) || 0
        content[index..(index + @TRUNCATION)]
      else
        content[0..@TRUNCATION]
      end
    if content && content.size > @TRUNCATION
      content << "..."
    end
    return content
  end
end