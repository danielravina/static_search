class StaticSearch::Search

  before do
    let(:index_builder) { StaticSearch::IndexBuilder.new }
  end

  def self.find_content(q)
    parsed_erb = index_builder.parse_file(example_file)
    text       = index_builder.to_text parsed_erb
    action     = index_builder.parse_action example_file
    StaticContent.where("content like %?%", q);
  end
end