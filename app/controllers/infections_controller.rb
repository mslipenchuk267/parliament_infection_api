require "uri"
require "net/http"
require 'json'

class InfectionsController < ApplicationController

    def submit
        # Make sure that temp IDs were actually provided
        if !params[:tempIDs].any?
            render json: {error: "No Temp ID Tokens Provided"}
            return
        end

        # Authenticate User
        # Assumble request
        uri_string = ENV['AUTH_URI'] + "/validate" 
        url = URI(uri_string)
        http = Net::HTTP.new(url.host, url.port);
        request = Net::HTTP::Post.new(url)
        request["Content-Type"] = "application/json"
        request.body = "{\n    \"accessToken\": \"#{params[:accessToken]}\"\n}"
        # Send request
        response = http.request(request)
        # Process result
        result = JSON.parse(response.read_body)

        # Check if accessToken was valid
        if result["status"] == "Valid Token"
            # Decode tempIdTokens param
            # infectionArray = []
            # begin
            #     params[:tempIdTokens].each do |encoded_token|
            #         decoded = JWT.decode(encoded_token, 's3cr3t', true, algorithm: 'HS256')
            #         # infection = Infection.create(temp_id: decoded[0]["temp_id"])
            #         infectionArray.push(decoded[0]["temp_id"])
            #     end
            # rescue
            #     render json: {error: "Invalid Temp ID Token"}
            #     return
            # end

            params[:tempIDs].each do |tempId|
                Infection.create(temp_id: tempId)
            end

            addedEntries = Infection.find(params[:tempIDs])

            # Return tempIDs back to user
            render json: {result: addedEntries}
        else 
            render json: {error: "Invalid Access Token"}
        end
        

    end

    # Gets temp ids from Infection table
    # IN - accessToken
    # OUT - temp_ids -> array of all temp id strings stored in Infection table
    def temp_ids
        begin
          decoded_access_token = JWT.decode(params[:accessToken], 's3cr3t', true, algorithm: 'HS256')
          if decoded_access_token
            @temp_ids = Infection.select(:temp_id, :created_at)
            render json: {temp_ids: @temp_ids}
          end
  
        rescue => exception
          render json: {status: "Invalid Token"}
        end
  
    end


    private

    def user_params
        params.permit(:temp_id)
    end
    
end
