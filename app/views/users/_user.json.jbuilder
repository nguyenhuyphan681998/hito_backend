json.extract! user, :id, :name, :email, :first_name, :last_name, :location, :phone, :profile_picture, :about, :uid, :provider, :created_at, :updated_at
json.url user_url(user, format: :json)
