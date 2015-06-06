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
        position = params[:position].map { |e| e.to_f } if params[:position]
        cab.update_attributes({position: position, available: params[:available]}.compact)
        status 204
      rescue Mongoid::Errors::DocumentNotFound
        status 404
      end
    end
  end


  params do
    requires :lat, type: Float, desc: "Customer's latitude"
    requires :lng, type: Float, desc: "Customer's longitude"
  end
  get 'eta' do
    if eta = EtaProvider.new(params[:lat], params[:lng]).average_for_nearby_cabs
      {eta: eta}
    else
      status 422
      {error: "Alas, no cabs available at the moment ;("}
    end
  end

end
