module Dnsimple
  class Client
    module DomainsZones

      # Gets a domain zone as zone file.
      #
      # @see http://developer.dnsimple.com/v1/domains/zones/#get
      #
      # @param  [#to_s] domain The domain id or domain name.
      # @return [String]
      #
      # @raise  [NotFoundError]
      # @raise  [RequestError] When the request fails.
      def zone(domain, options = {})
        response = client.get(Client.versioned("/domains/#{domain}/zone"), options)

        response["zone"]
      end

    end
  end
end
