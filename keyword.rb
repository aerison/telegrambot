require 'telegram/bot'

token=ENV["telegram_token"]

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    when '/manager'
      bot.api.send_message(chat_id: message.chat.id, text: "매니저님 화이팅")
    end
  end
end

#https://github.com/atipugin/telegram-bot-ruby
#실행코드는 ruby keyword.rb  -->챗봇에서 알아서, 돌려줌!
#41DF