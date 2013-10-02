require 'goliath'
require 'httparty'
# For Fog::Mock helpers
require 'fog'

class PactoServer < Goliath::API

	def response (env)
    path = env[Goliath::Request::REQUEST_PATH]
  	headers = env['client-headers']
    begin
      uri = "#{config[:backend]}#{path}"
      puts "Calling #{uri}"
  	 resp = HTTParty.get(uri)
     code = resp.code
     [resp.code, resp.headers, resp.body]
    rescue => e
      [500, {}, e.message]
    end
	end

	def options_parser(opts, options)
		options[:strict] = false
    options[:directory] = "contracts"
		opts.on('-m', '--match-strict', 'Should enforce headers strict matching') { |val| options[:strict] = true }
    opts.on('-x', '--contracts_dir DIR', 'Directory that contains the contracts to be registered') { |val| options[:directory] = val }
    opts.on('-H', '--host HOST', 'Host of the real service, for validating live requests') { |val| options[:backend_host] = val }
	end

  def on_headers(env, headers)
    env['client-headers'] = headers
  end

end
