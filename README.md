pacto_server_spike
==================

Try it out:

- Start the stub server: ```bundle exec ruby pactoserver.rb -c config/pactoserver.rb -sv```
- Start a (validating) proxy server: ```bundle exec ruby pactoserver.rb -c config/pactoserver.rb -sv -p 9001 -H 'http://rackspace.apiary.io'```

- Get a stub response:  ```curl "localhost:9000/v2/0/servers/1" | python -m json.tool```
- Get a proxied response: ```curl "localhost:9001/v2/0/servers/1" | python -m json.tool```
