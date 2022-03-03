module ApplicationHelper
  def markdown(text)
    markdown_to_html = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                                               autolink: true,
                                               space_after_headers: true)
    markdown_to_html.render(text).html_safe
  end

  # Returns the monster instance variable based on id
  def fetch_monster(id)
    @monster = Monster.find(id)
  end
end
