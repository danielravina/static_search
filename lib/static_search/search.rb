class StaticSearch::Search
  @TRUNCATION = 220

  def self.find_content(q)
    return [] unless q.present?
    result = StaticContent.where("content like ? OR title like ?", "% #{q} %", "%#{q}%");
    return result.map do |page|
      page = page.as_json
      page["content"] = truncate_body(page["content"], q)
      page
    end
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