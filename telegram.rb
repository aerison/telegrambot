require 'rest-client' #요청을 보내는 애
require 'json'
require 'nokogiri'
require 'open-uri'

 

# url = "http://www.ruby-lang.org/en/community/"  
# doc = Nokogiri::HTML(doc = open(url))  
# doc.xpath('//div[@id="content"]/dl/dt/a').each do |a|  
#   puts a.content
# end  

#근데 이건 왜안됨.. http error
#   news_list=Array.new
#   doc = Nokogiri::HTML(open("https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=&oquery=%EC%83%88%EA%B8%80%EC%95%8C%EB%A6%BC&tqi=TzxeWlpVuERssce2XvRssssst7Z-203222"))
#           doc.css('ol.1st_realtime_srch _tab_area li a').each do |location| 
#               @news_list << location.attr('href').text
#           end
#           @news_list

# news_list=Array.new
# @url="https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=&oquery=%EC%83%88%EA%B8%80%EC%95%8C%EB%A6%BC&tqi=TzxeWlpVuERssce2XvRssssst7Z-203222"
# res=RestClient.get(@url)
# @res_doc  = Nokogiri::XML(res)
# res_url = @res_doc.xpath("//url").text  

video_url=Array.new
video_title=Array.new
video_list=Hash.new
url = "https://www.youtube.com/channel/UC-IYpdOqjkER7B6cnChwlhA/videos"
res=RestClient.get(url)
doc=Nokogiri::HTML(res)
doc.css('.yt-lockup-title').each do |video|
    video_url << "https://www.youtube.com"+video.at('a')['href']
    video_title << video.at('a')['title']
end

20.times do |i|
    video_list[i] = {url: video_url[i], title: video_title[i]}
end

# (1..20).each_with_index do |i, index|
# video_list["#{video_url[i]}"]=video_title[i]
# end

token=ENV["telegram_token"]
url="https://api.telegram.org/bot"+"#{token}"+"/getUpdates"
res =RestClient.get(url)
res_json  = JSON.parse(res)
user_id=res_json['result'][0]['message']['from']['id']



video_msg=""

20.times do |i|
    video_msg += "["+"#{i+1}"+"]"+video_list[i][:title] + " : " + video_list[i][:url] + "\n" 
# video_msg = video_list[0][:title] + " : " + video_list[0][:url] 
end
msg_url=URI.encode("https://api.telegram.org/bot"+"#{token}"+"/sendmessage?chat_id=#{user_id}&text=#{video_msg}")
RestClient.get(msg_url)

#puts video_url
#puts video_title



# doc.css('#title > a').each do |loc|
#     video_url << loc.attr('href')
#     video_title << loc.text
# end

# (1..60).each do |i|
# video_list["#{video_url[i]}"]=video_title[i]
# end

# token='577998246:AAHYLNWbZlQQlj3L34K4BMbvPhCAJeZFD14'
# url="https://api.telegram.org/bot"+"#{token}"+"/getUpdates"
# res =RestClient.get(url)
# res_json  = JSON.parse(res)
# user_id=res_json['result'][0]['message']['from']['id']
# video_msg=video_list['#{video_url[i]}']
# msg_url=URI.encode("https://api.telegram.org/bot"+"#{token}"+"/sendmessage?chat_id=#{user_id}&text=#{video_msg}")
# RestClient.get(msg_url)

# #puts res_json



#every.each do |play|
#end

