require 'openid'
require 'openid/extensions/ax'
require 'available_attributes'

class MojeID
  attr_accessor :moje_id_request, :moje_id_response, :fetch_request, :fetch_response, :realm, :return_to

  def self.fetch_request(consumer, openid_identifier, request_type = :get)
    moje_id = MojeID.new
    moje_id.moje_id_request = consumer.begin(openid_identifier)
    moje_id.set_fetch_request_by_type(request_type)
    moje_id
  end

  def self.fetch_response(consumer, params, request, current_url, request_type = :get)
    moje_id = MojeID.new
    parameters = params.reject{|k,v| request.path_parameters[k]}
    moje_id.fetch_response = consumer.complete(parameters, current_url)
    moje_id.set_response_by_type(request_type) if moje_id.response_status == OpenID::Consumer::SUCCESS
    moje_id
  end

  def response_status
    fetch_response.status
  end

  def identifier
    fetch_response.display_identifier
  end

  def message
    fetch_response.display_identifier
  end

  def data
    (!moje_id_response.nil? && moje_id_response.respond_to?('data') ) ? moje_id_response.data : {}
  end

  def add_attributes(attributes = [])
    attributes.each{ |attribute| add_attribute(attribute)}
  end
  
  def update_attributes(data = {})
    data.each{ |attribute,value| set_attribute(attribute, value)}
  end

  def add_additional_data(data = {})
    data.each{|k,v| moje_id_request.return_to_args[k.to_s] = v}
    bundle_to_request
  end
  
  def send_redirect?(immediate = false)
    moje_id_request.send_redirect?(realm, return_to, immediate)
  end

  def redirect_url(immediate = false)
    moje_id_request.redirect_url(realm, return_to, immediate)
  end

  def html_markup(realm, return_to, immediate = false, form_tag_attrs = {})
    moje_id_request.html_markup(realm, return_to, immediate, form_tag_attrs)
  end

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
  
  def add_attribute(attribute)
    if MojeID.is_attribute_available?(attribute)
      fetch_request.add(OpenID::AX::AttrInfo.new(attribute))
      bundle_to_request
    end
  end

  def set_attribute(attribute, value)
    if MojeID.is_attribute_available?(attribute)
      fetch_request.set_values(attribute, value)
      bundle_to_request
    end
  end

  def self.is_attribute_available?(attribute)
    MojeIDAttributes::AVAILABLE_ATTRIBUTES.include?(attribute) ? true : raise("#{attribute} is not available")
  end

end