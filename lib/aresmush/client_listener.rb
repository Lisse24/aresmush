module AresMUSH

  # This class exists to offload the thread-centric stuff so the controller can be more testable.
  class ClientListener

    def start(server, controller)
      loop {
        @thread = Thread.start(server.accept) do |client|
          controller.client_connected(client)
          while line = client.gets 
            controller.client_input(client, line)
          end
        end   
      }   
    end

    def stop
      @thread.exit
    end

  end
end
