class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    before_action :set_locale
     
    def set_locale
      if params[:locale]
        cookies['locale'] = params[:locale]
      end
      locale = cookies['locale'].to_s.strip.to_sym
      I18n.locale = I18n.available_locales.include?(locale) ?
          locale :
          I18n.default_locale
    end

    def extract_locale_from_tld
      parsed_locale = request.host.split('.').last
      I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    end

    def default_url_options
      { locale: I18n.locale }
    end

    def set_locale_cookie(locale)
      cookies['locale'] = locale.to_s
    end

end
