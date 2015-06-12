require 'socket'
require 'json'

server = TCPServer.new(9999)
loop do
  Thread.start(server.accept) do |client|   
    request = client.read_nonblock(256)
    (header, request_body) = request.split("\r\n\r\n", 2)
   
    method = header.split[0]
    path = header.split[1]
    
    if File.exist?(path)  
      response_body = File.read(path) 	 
      client.print "HTTP/1.1 200 OK\r\nContent-type:text/html\r\n\r\n"
      if method == 'GET'  
        client.print "\r\n"  #print empty line, as required by the protocol
        client.print response_body
      elsif method == 'POST'
      	client.print request_body
        params = JSON.parse(request_body)
        user_data = "<li>name: #{params['person']['name']}</li><li>e-mail: #{params['person']['email']}</li>"
      	client.print "\r\n"
      	client.print response_body.gsub('<%= yield %>', user_data)
      end
    else 
      client.print "HTTP/1.1 404 ERROR\r\nContent-type:text/html\r\nPage not found\r\n"
    end
    client.close
  end
end