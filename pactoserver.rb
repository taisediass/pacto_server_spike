require 'goliath'
require 'httparty'

class PactoServer < Goliath::API

	def response (env)
  	path = env[Goliath::Request::REQUEST_PATH]
  	headers = env['client-headers']
  	resp = HTTParty.get("http://www.mydomain.com:9001#{path}", headers: headers)
  	[resp.code, resp.headers, resp.body]
	end

	def options_parser(opts, options)
		options[:strict] = false
    options[:directory] = "."
		opts.on('-m', '--match-strict', 'Should enforce headers strict matching') { |val| options[:strict] = true }
    opts.on('-x', '--contracts_dir DIR', 'Directory that contains the contracts to be registered') { |val| options[:directory] = val }
	end

  def on_headers(env, headers)
    env['client-headers'] = headers
  end

end