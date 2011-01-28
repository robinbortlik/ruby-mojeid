require 'openid'
require 'openid/extensions/ax'
require 'available_attributes'

class MojeID
  attr_accessor :moje_id_request, :moje_id_response, :fetch_request, :fetch_response, :realm, :return_to

  # Prepare request for openid server 
  # 
  # openid_identifier is user identifier like fullname.mojeid.cz
  # consumer is object of OpenID::Consumer class.
  #
  # here is example how to create consumer
  # * store = OpenID::Store::Memcache.new(MemCache.new('localhost:11211'))
  # * @consumer = OpenID::Consumer.new(session, store)
  #
  # You can choose if you will be read data or store data by request_type param
  # * request_type == :get mean that you will be read data about user
  # * request_type == :put mean that you will be store data about user
  #
  # here is example how to create MojeID fetch request
  # * @moje_id = MojeID.fetch_request(@consumer, 'fullname.mojeid.cz')

  def self.fetch_request(consumer, openid_identifier, request_type = :get)
    moje_id = MojeID.new
    moje_id.moje_id_request = consumer.begin(openid_identifier)
    moje_id.set_fetch_request_by_type(request_type)
    moje_id
  end

  # Get response from openid server
  #
  # * consumer is object of OpenID::Consumer class, like in the fetch_request method
  # * params are a params from request which openid server send to you
  # * request is a request object from controller. It is necessary to remove dirty params
  # * current_url is url of action which recieve the openid server response
  # * with request_type you say, if this response become from get request or put request
  #
  # here is example how to create MojeID fetch response 
  # * @moje_id = MojeID.fetch_response(@consumer, params, request, url_for(:action => 'complete_update_data', :only_path => false), :put)

  def self.fetch_response(consumer, params, request, current_url, request_type = :get)
    moje_id = MojeID.new
    parameters = params.reject{|k,v| request.path_parameters[k]}
    moje_id.fetch_response = consumer.complete(parameters, current_url)
    moje_id.set_response_by_type(request_type) if moje_id.response_status == OpenID::Consumer::SUCCESS
    moje_id
  end


  # Return the status of openid server response
  # the statuses are :
  # * OpenID::Consumer::FAILURE
  # * OpenID::Consumer::SUCCESS
  # * OpenID::Consumer::SETUP_NEEDED
  # * OpenID::Consumer::CANCEL
  
  def response_status
    fetch_response.status
  end

  # Return the openid identifier like fullname.mojeid.cz
  def identifier
    fetch_response.display_identifier
  end

  # Return the response message
  def message
    fetch_response.message
  end

  # Return data parsed to Hash, if it is a "fetch_response" with request_type == :get, else return blank Hash
  def data
    (!moje_id_response.nil? && moje_id_response.respond_to?('data') ) ? moje_id_response.data : {}
  end

  # Add attributes you would like to read about user, to request.
  def add_attributes(attributes = [])
    attributes.each{ |attribute| add_attribute(attribute)}
  end

  # Add attributes and they values which you would like to update user profile, to request.
  # Accept hash like {'http://axschema.org/namePerson' => 'my new great name'}
  def update_attributes(data = {})
    data.each{ |attribute, value| set_attribute(attribute, value)}
  end

  # Add additional data to request
  # Accept hash like {'is_this_my_request' => 'yes'}
  def add_additional_data(data = {})
    data.each{|k,v| moje_id_request.return_to_args[k.to_s] = v}
    bundle_to_request
  end

  # Should this OpenID authentication request be sent as a HTTP redirect or as a POST (form submission)?
  def send_redirect?(immediate = false)
    moje_id_request.send_redirect?(realm, return_to, immediate)
  end

  # Return the url you have to redirect after you compose your request
  def redirect_url(immediate = false)
    moje_id_request.redirect_url(realm, return_to, immediate)
  end

  # Get a complete HTML document that autosubmits the request to the IDP with javascript.
  def html_markup(realm, return_to, immediate = false, form_tag_attrs = {})
    moje_id_request.html_markup(realm, return_to, immediate, form_tag_attrs)
  end

  # Return a value of attribute, when you recieve a data from openid server
  def get_attribute_value(attribute)
    data[attribute]
  end

  
  def set_fetch_request_by_type(request_type)
    self.fetch_request = case request_type
    when :get then OpenID::AX::FetchRequest.new
    when :put then OpenID::AX::StoreRequest.new
    end
  end

  def set_response_by_type(request_type)
    self.moje_id_response = case request_type
    when :get then OpenID::AX::FetchResponse.from_success_response(self.fetch_response)
    when :put then OpenID::AX::StoreResponse.from_success_response(self.fetch_response)
    end
  end

  private

  def bundle_to_request
    moje_id_request.add_extension(fetch_request)
  end

  # Pack attribute to request when you would like to get attribute
  def add_attribute(attribute)
    if MojeID.is_attribute_available?(attribute)
      fetch_request.add(OpenID::AX::AttrInfo.new(attribute))
      bundle_to_request
    end
  end

  # Pack attribute and his value to request when you would like to store attribute
  def set_attribute(attribute, value)
    if MojeID.is_attribute_available?(attribute)
      fetch_request.set_values(attribute, value)
      bundle_to_request
    end
  end

  # Check if the attribute is available. You can find full list of attributes in lib/available_attributes.rb
  def self.is_attribute_available?(attribute)
    MojeIDAttributes::AVAILABLE_ATTRIBUTES.include?(attribute) ? true : raise("#{attribute} is not available")
  end

end