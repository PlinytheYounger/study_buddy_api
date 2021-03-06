class SessionsController < ApplicationController
    include CurrentUserConcern
    # create new user
    def create
        user = User
            .find_by(username: params["user"]["username"])
            .try(:authenticate, params["user"]["password"])

        if user
            session[:user_id] = user.id 
            render json: {
                status: :created,
                logged_in: true,
                user: user.to_json(include: [:concepts, :interviews])
            }
        else
            render json: { status: 401 }
        end
    end

    # log in
    def logged_in
        if @current_user
            render json: {
                logged_in: true,
                user: @current_user
            }
        else
            render json: {
                logged_in: false
            }
        end
    end

    # log out
    def logout
        reset_session
        render json: { status: 200, logged_out: true}
    end

    private
        # returns a hash that contains the payload including the user's id and username to be encrypted
        def payload(id, username)
            {
              exp: (Time.now + 30.minutes).to_i,
              iat: Time.now.to_i,
              iss: ENV['JWT_ISSUER'],
              user: {
                id: id,
                username: username
              }
            }
          end
      
          # method that creates the token with the payload
          def create_token(id, username)
            JWT.encode(payload(id, username), ENV['JWT_SECRET'], 'HS256')
          end
end