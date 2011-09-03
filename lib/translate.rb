require 'nokogiri'
require 'net/http'

module Microsoft
  class Translate
    attr_accessor :app_id, :http, :lang, :languages, :request, :translation

    def initialize(app_id=nil)
      raise 'Call to new should have an application id' unless app_id
      self.app_id = app_id
      self.http = TranslateHTTP.new(app_id)
    end

    def get_languages
      self.languages = self.languages.nil? ? self.http.send_get_languages : self.languages
    end

    def translate(text, opts={})
      from_lang = opts[:from].to_s
      to_lang = opts[:to].to_s
      self.translation = self.http.send_translate(text,from_lang,to_lang)
    end

    def detect(text)
      self.lang = self.http.send_detect(text)
    end



    class TranslateHTTP
      attr_accessor :action, :app_id, :request, :response

      def initialize(app_id)
        self.app_id = app_id
      end

      def send_detect(text)
        self.action = "http://api.microsofttranslator.com/V2/Http.svc/Detect"
        escaped_text = URI.escape(text)
        do_get_request("text=#{escaped_text}")
        Nokogiri::HTML(self.response).xpath('//string').first.content
      end

      def send_get_languages
        self.action = "http://api.microsofttranslator.com/V2/Http.svc/GetLanguagesForTranslate"
        do_get_request
        Nokogiri::HTML(self.response).xpath('//string').map(&:content)
      end

      def send_translate(text,from,to)
        self.action = "http://api.microsofttranslator.com/V2/Http.svc/Translate"
        text = URI.escape(text)
        params = "&contentType=text/plain&category=general&from=#{from}&to=#{to}&text=#{text}"
        do_get_request(params)
        Nokogiri::HTML(self.response).xpath('//string').first.content
      end

      private
        def do_get_request(params=nil)
          url = self.action + "?appId=#{self.app_id}"
          url = url + '&' + params unless params.nil?
          uri = URI.parse(url)
          http = Net::HTTP.new(uri.host,uri.port)
          self.request = Net::HTTP::Get.new(uri.request_uri)
          self.response = http.request(self.request).body
        end
    end

  end
end
