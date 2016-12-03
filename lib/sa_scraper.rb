class SAScraper 
  def initialize
    @agent = Mechanize.new
  end

  def main_logic(thread, file_name = "myfile.txt" )
    page = login(thread)
    time = Time.now
    thread_id = get_thread_id(page)
    store(file_name, "thread id is #{thread_id}")
    loop do
      sleep(0.5)
      posts = get_posts(page, file_name)
      break unless page.link_with(:text => '›')
      page = page.link_with(:text => '›').click
      time_now = Time.new
    end
    time_now = Time.new
    puts "total run time #{time_now - time}"
  end

  def login(thread_given)
    my_page = @agent.get(thread_given)
    login_page = @agent.click(my_page.link_with(:text => /LOG IN/))
    my_page = login_page.form_with(:action => 'https://forums.somethingawful.com/account.php')
    my_page.fields[1].value = ENV["sausername"]
    my_page.fields[2].value = ENV["sapassword"]
    my_page.click_button
  end

  def get_thread_id(page)
     thread_id = page.parser.at('div#thread').attributes['class']
     thread_id.to_s[7..-1]
  end

  def sanitize(page)
    
  end

  def get_posts(page, file_name = "myfile.txt")
    posts = page.parser.css("table")
    posts.xpath('//comment()').each { |comment| comment.remove }
    posts.search('p.editedby').each { |p| p.remove }
    posts.each do |post|

      get_and_store(post, "dt.author", file_name)

      get_and_store(post, "dd.registered", file_name)

      get_and_store(post, "dd.title", file_name)

      post.css("div.bbc-center").css("img.img").each do |avatar|
        open(file_name, 'a+') do |f|
          f.puts avatar.attribute('src')
        end
      end

      get_and_store(post, "td.postbody", file_name)

    end

  end

  def get_and_store(post, target, file_name)
    post.css(target).each do |post|
      store(file_name, post)
    end
  end

  def store(file_name, content)
    open(file_name, 'a+') do |f|
      f.puts content
    end
  end

  def save_posts(post)
    post.save! 'test.txt'
  end
end