require 'bundler/setup'

module BinnacleChat
  class Engine < ::Rails::Engine
    initializer "binnacle_chat.load_initializer" do
      ActiveSupport.on_load(:action_controller) do
        include BinnacleChat::Initializer
      end
    end
  end
end
