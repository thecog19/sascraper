class SAScraper 
  def initialize 
    @agent = Mechanize.new
  end

  def login
    my_page = @agent.get("http://forums.somethingawful.com/showthread.php?threadid=3706905")
    login_page = @agent.click(my_page.link_with(:text => /LOG IN/))
    my_page = login_page.form_with(:action => 'https://forums.somethingawful.com/account.php')
    my_page.fields[1].value = ENV["sausername"]
    my_page.fields[2].value = ENV["sapassword"]
    my_page = my_page.click_button
    save_posts(my_page)
  end

  def get_posts
    page = @agent.get('http://google.com/')
  end

  def save_posts(post)
    post.save! 'test.txt'
  end
end