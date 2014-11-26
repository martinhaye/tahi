class SessionsController < Devise::SessionsController
  def create
    respond_to do |format|
      format.html { super }
      format.json do
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        data = {
          user_token: "1234",
          user_email: self.resource.email,

          first_name: self.resource.first_name,
          last_name: self.resource.last_name,
          username: self.resource.username,
          avatar: self.resource.avatar
        }
        render json: data, status: 201
      end
    end
  end

  def failure
    return render :json => {:success => false, :errors => ["Login failed."]}
  end
end
