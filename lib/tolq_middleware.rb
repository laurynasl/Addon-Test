require 'net/http'
require 'net/https'

module Tolq
  class Middleware
    def initialize(app, *args, &block)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)

      if headers["Content-Type"] =~ /text\/html|application\/xhtml\+xml/
        body = ""
        response.each { |part| body << part }

        tolq_url = ENV['TOLQ_URL']
        if tolq_url
          uri = URI.parse(tolq_url)

          if ['http', 'https'].include?(uri.scheme)
            http = Net::HTTP.new(uri.host, uri.port)
            if uri.scheme == 'https'
              http.use_ssl = true
              http.verify_mode = OpenSSL::SSL::VERIFY_PEER
              http.ca_path = '/etc/ssl/certs'
            end

            #path = env['ORIGINAL_FULLPATH']
            path = env['REQUEST_PATH']
            path += '?' + env['QUERY_STRING'] if env['QUERY_STRING']
            req = Net::HTTP::Post.new(uri.request_uri)
            req.set_form_data({
              'document_type' => 'html',
              'document' => body,
              'language_header' => env['HTTP_ACCEPT_LANGUAGE'],
              'hostname' => env['HTTP_HOST'],
              'path' => path
            })
            res = http.request(req)
          else
            raise 'Unexpected scheme'
          end
          if res.code == '200'
            new_body = res.body
            headers["Content-Length"] = new_body.length.to_s
            response = [new_body]
          else
            puts "response code: #{res.code}"
          end
        else
          puts "environment variable TOLQ_URL is not provided!"
        end
      end

      [status, headers, response]
    end
  end
end
