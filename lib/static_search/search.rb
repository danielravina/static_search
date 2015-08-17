class StaticSearch::Search

  def self.find_content(q, options = {})
    return [] unless q.present?
    result = StaticContent.where("LOWER(content) like ? OR LOWER(title) like ?", "%#{q}%", "%#{q}%");
    if options[:truncation]
      return result.map do |page|
        page = page.as_json
        page["content"] = truncate_body(page["content"], q, options[:truncation])
        page
      end
    else
      return result.map(&:as_json)
    end
  end

  def self.truncate_body content, q, truncation_size
    content = \
      if content.include? q
        index = content.downcase.index(q.downcase) || 0
        content[index..(index + truncation_size)]
      else
        content[0..truncation_size]
      end
    if content && content.size > truncation_size
      content << "..."
    end
    return content
  end
end