require 'json'
require 'socket'

class Connection
  attr_accessor :request, :path, :name, :email
  attr_reader :host, :port

  def initialize
    @host = 'localhost'
    @port = 9999
    @request = nil
    @path = nil
    @name = nil
    @email = nil
  end

  def get_request
    @request = 'GET'
    puts "Enter path"
    @path = gets.chomp
    request = generate_request
    send(request)
  end

  def post_request
    @request = 'POST'
    @path = 'thanks.html'
    puts "Enter your name"
    @name = gets.chomp
    puts "Enter your email"
    @email = gets.chomp
    body = generate_body
    request = generate_request(body)
    send(request)
  end

  def send(request)
    socket = TCPSocket.open(@host, @port)
    socket.write(request)
    response = socket.read
    puts response 
    socket.close
  end

  def generate_body
    body = {person: {name: @name, email: @email}}
    body.to_json
  end

  def generate_request(body = nil)
    if body.nil?
      "#{@request} #{@path} HTTP/1.0\r\n\r\n"
    else
      length = body.length
      "#{@request} #{@path} HTTP/1.0\r\nContent-Length:#{length}\r\n\r\n#{body}"
    end
  end
end