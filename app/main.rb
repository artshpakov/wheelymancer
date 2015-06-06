class Wheelymancer < Grape::API

  version 'v1', using: :path
  format :json
  prefix :api


  resource :cabs do
    params do
      requires :id, type: String, desc: "Cab ID"
    end
    put ':id' do
      begin
        cab = Cab.find(params[:id])
        cab.update_attributes(params.slice('position','available').compact)
        status 204
      rescue Mongoid::Errors::DocumentNotFound
        status 404
      end
    end
  end

end
