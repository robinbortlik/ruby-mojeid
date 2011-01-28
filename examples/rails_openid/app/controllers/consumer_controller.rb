class ConsumerController < ApplicationController
  layout nil

  def index
    # render an openid form
  end


  # EXAMPLE HOW TO RETRIEVE DATA FROM MOJEID
  def start_get_data
    begin
      identifier = params[:openid_identifier].to_s + params[:openid_domain].to_s
      @moje_id = MojeID.fetch_request(consumer, identifier)
    rescue OpenID::OpenIDError => e
      flash[:error] = "Discovery failed for #{identifier}: #{e}"
      return redirect_to :action => 'index'
    end
    
    @moje_id.add_attributes(MojeIDAttributes::AVAILABLE_ATTRIBUTES[0..3])
    @moje_id.return_to = url_for(:action => 'complete_get_data', :only_path => false)
    @moje_id.realm = url_for(:action => 'index', :id => nil, :only_path => false)
    redirect_to @moje_id.redirect_url
  end

  def complete_get_data
    current_url = url_for(:action => 'complete_get_data', :only_path => false)
    @moje_id = MojeID.fetch_response(consumer, params, request, current_url)
    reflect_moje_id_response_status
    render :action => 'index'
  end


  # EXAMPLE HOW TO UPDATE DATA TO MOJEID
  def start_update_data
    begin
      identifier = params[:openid_identifier]
      @moje_id = MojeID.fetch_request(consumer, identifier, :put)
    rescue OpenID::OpenIDError => e
      flash[:error] = "Discovery failed for #{identifier}: #{e}"
      return redirect_to :action => 'index'
    end

    @moje_id.update_attributes(params[:moje_id_attributes])
    @moje_id.return_to = url_for(:action => 'complete_update_data', :only_path => false)
    @moje_id.realm = url_for(:action => 'index', :id => nil, :only_path => false)
    redirect_to @moje_id.redirect_url
  end

  def complete_update_data
    current_url = url_for(:action => 'complete_update_data', :only_path => false)
    @moje_id = MojeID.fetch_response(consumer, params, request, current_url, :put)
    reflect_moje_id_response_status
    render :action => 'index'
  end

  private

  require 'openid/store/memcache'
  require 'memcache'

  def consumer
    if @consumer.nil?
      store = OpenID::Store::Memcache.new(MemCache.new('localhost:11211'))
      @consumer = OpenID::Consumer.new(session, store)
    end
    return @consumer
  end

  def reflect_moje_id_response_status
    case @moje_id.response_status
    when OpenID::Consumer::FAILURE then flash[:error] = "Verification failed: #{@moje_id.message}"
    when OpenID::Consumer::SUCCESS then flash[:success] = ("Verification of #{@moje_id.identifier} succeeded.")
    when OpenID::Consumer::SETUP_NEEDED then flash[:alert] = "Immediate request failed - Setup Needed"
    when OpenID::Consumer::CANCEL then flash[:alert] = "OpenID transaction cancelled."
    else
    end
  end
  
end
