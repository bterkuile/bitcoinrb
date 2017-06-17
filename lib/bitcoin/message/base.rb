module Bitcoin
  module Message

    # Base message class
    class Base
      include Bitcoin::Util
      extend Bitcoin::Util

      # generate message header (binary format)
      # https://bitcoin.org/en/developer-reference#message-headers
      def to_pkt
        payload = to_payload
        magic = Bitcoin.chain_params.magic_head.htb
        command_name = command.ljust(12, "\x00")
        payload_size = [payload.bytesize].pack('V')
        checksum = Digest::SHA256.digest(Digest::SHA256.digest(payload))[0...4]
        magic << command_name << payload_size << checksum << payload
      end

      def command
        raise 'to_payload must be implemented in a child class.'
      end

      # abstract method
      def to_payload
        raise 'to_payload must be implemented in a child class.'
      end

    end

  end
end
