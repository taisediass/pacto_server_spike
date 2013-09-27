require 'goliath'
require 'httparty'

class PactoServer < Goliath::API

	def response (env)
  	path = env[Goliath::Request::REQUEST_PATH]
  	headers = env['client-headers']
  	resp = HTTParty.get("http://www.mydomain.com:9001#{path}", headers: headers)
  	[200, {}, resp.body]
	end

	def options_parser(opts, options)
		options[:strict] = false
		opts.on('-m', '--match-strict', 'Should enforce headers strict matching') { |val| options[:strict] = true }
	end

  def on_headers(env, headers)
    env['client-headers'] = headers
  end

end