require 'goliath'
require 'httparty'

class PactoServer < Goliath::API
	def response (env)	
	resp = HTTParty.get('http://www.mydomain.com:9001/c1', headers: {'Accept' => 'application/json'})
	[200, {}, resp.body]
	end
end