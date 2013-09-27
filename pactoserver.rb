require 'goliath'
require 'httparty'

class PactoServer < Goliath::API

	def options_parser(opts, options)
		options[:strict] = false
		opts.on('-x', '--strict', 'Should do strict matching') { |val| options[:strict] = true }
	end

	def response (env)	
	# env[Goliath::Request::REQUEST_METHOD]
	# 	
	path = env[Goliath::Request::REQUEST_PATH]
	headers = env['client-headers']
	resp = HTTParty.get("http://www.mydomain.com:9001#{path}", headers: headers)
	#resp = HTTParty.get('http://www.mydomain.com:9001/c1', headers: {'Accept' => 'application/json'})
	[200, {}, resp.body]
	end
end