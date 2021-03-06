class LinebotController < ApplicationController
 require 'line/bot'

  protect_from_forgery :except => [:callback]

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)

    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          # LINEから送られてきたメッセージが「アンケート」と一致するかチェック
          if event.message['text'].eql?('面談')
            # private内のtemplateメソッドを呼び出します。
            client.reply_message(event['replyToken'], template)
          elsif event.message['text'].eql?('入会')
            client.reply_message(event['replyToken'], template1)
          elsif event.message['text'].eql?('質問')
            client.reply_message(event['replyToken'], template2) 
          end
        end
      end
    }

    head :ok
  end

  private

  def template
    {
      "type": "template",
      "altText": "面談希望",
      "template": {
          "type": "confirm",
          "text": "面談を希望しますか？",
          "actions": [
              {
                "type": "message",
                # Botから送られてきたメッセージに表示される文字列です。
                "label": "はい",
                # ボタンを押した時にBotに送られる文字列です。
                "text": "面談希望しました。"
              },
              {
                "type": "message",
                "label": "いいえ",
                "text": "キャンセルしました。"
              }
          ]
      }
    }
  end
  
    def template1
    {
      "type": "template",
      "altText": "入会希望",
      "template": {
    
          "type": "buttons",
          "text": "入会希望",
          "actions": [
               { "type": "uri",
                # Botから送られてきたメッセージに表示される文字列です。
                "label": "入会はこちら",
                # ボタンを押した時にBotに送られる文字列です。
                "uri": "https://serene-scrubland-29400.herokuapp.com"
               }
                ],
      }
    }
    end
    
    def template2
    {
      "type": "template",
      "altText": "質問希望",
      "template": {
          "type": "buttons",
          "text": "質問希望",
          "actions": [
            {
            "type": "uri",
            "label": "質問はこちら",
            "uri": "https://line.me/R/ti/p/@850nnrsb"
            }
      ]
      }
    }
    end
end
