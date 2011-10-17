module SaveFixture
  def save_fixture(selector, name)
    html = html_for(selector)
    path = File.join(Rails.root, 'spec/javascripts/fixtures')

    file_path = File.join(path, "#{name}.html")
    File.open(file_path, 'w') do |f|
      f.puts(html)
    end
  end

  def html_for(selector='body')
    doc = Nokogiri::HTML(fixture_html).css(selector)
    clean_html(doc)
  end

  def clean_html(doc)
    doc.search('script').try(:remove)
    doc.search('iframe').try(:remove)
    doc.search('img').each do |image|
      image['src'] = 'data:image/gif;base64,R0lGODlhAQABAIAAAP///////yH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=='
    end
    doc.to_s.gsub('<body', '<div').gsub('</body', '</div')
  end

end

# Mix save_fixture in for use by controller and view specs

require 'nokogiri'
module RSpec::Rails::ControllerExampleGroup
  include SaveFixture

  def fixture_html
    response.body
  end
end

module RSpec::Rails::ViewExampleGroup
  include SaveFixture

  def fixture_html
    rendered
  end

  def doc
    @doc ||= Nokogiri::HTML(rendered)
  end
end