class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper
    skip_before_action :verify_authenticity_token

    def search
    	@search = User.search name_cont: params[:q]
    	return if @search.nil?
    	@users = @search.result	
    	respond_to do |f|
    		f.html {render partial: "layouts/user", collection: @users}
    	end
    end
end
