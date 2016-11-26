class SAScraper 
  def initialize
    @agent = Mechanize.new
  end

  def main_logic(thread)
    page = login(thread)
    posts = get_posts(page)
  end

  def login(thread_given)
    my_page = @agent.get(thread_given)
    login_page = @agent.click(my_page.link_with(:text => /LOG IN/))
    my_page = login_page.form_with(:action => 'https://forums.somethingawful.com/account.php')
    my_page.fields[1].value = ENV["sausername"]
    my_page.fields[2].value = ENV["sapassword"]
    my_page = my_page.click_button
  end

  def get_posts(page)
    posts = page.parser.css("table")
    posts.each do |post|
      post.css("td.postbody").each do |td|
        open('myfile.txt', 'a+') do |f|
          f.puts td
        end
      end
    end
  end

  def save_posts(post)
    post.save! 'test.txt'
  end
end