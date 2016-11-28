class SAScraper 
  def initialize
    @agent = Mechanize.new
  end

  def main_logic(thread)
    page = login(thread)
    time = Time.now
    loop do
      sleep(0.5)
      posts = get_posts(page)
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

  def get_posts(page)
    posts = page.parser.css("table")
    posts.xpath('//comment()').each { |comment| comment.remove }
     posts.search('p.editedby').each { |p| p.remove }

    thread_id = page.parser.css('div#thread')
    #have to figure out how to grab thread id
    pp thread_id

    posts.each do |post|

      post.css("dt.author").each do |author|
        open('myfile.txt', 'a+') do |f|
          #this will be replaced with a db
          f.puts author.text
        end
      end

      post.css("dd.registered").each do |reg_date|
        open('myfile.txt', 'a+') do |f|
          #this will be replaced with a db
          f.puts reg_date.text
        end
      end

      post.css("dd.title").each do |title|
        open('myfile.txt', 'a+') do |f|
          f.puts title.text
        end
      end

      post.css("div.bbc-center").css("img.img").each do |avatar|
        open('myfile.txt', 'a+') do |f|
          f.puts avatar.attribute('src')
        end
      end

      post.css("td.postbody").each do |post|
        open('myfile.txt', 'a+') do |f|
          #this will be replaced with a db
          f.puts post
        end
      end

    end
  end

  def save_posts(post)
    post.save! 'test.txt'
  end
end