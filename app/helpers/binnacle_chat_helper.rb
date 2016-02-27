module BinnacleChatHelper
  def chat(options = {})
    options[:id] ||= "binnacle_chat"
    options[:room] ||= "binnacle_chat"
    options[:title] ||= "Chat"
    render(
      partial: "binnacle_chat/binnacle_chat",
      locals: {
        binnacle_chat_id: options[:id],
        binnacle_chat_room: options[:room],
        binnacle_chat_identity: options[:identity],
        binnacle_chat_email: options[:email],
        binnacle_chat_display_name: options[:display_name],
        binnacle_chat_title: options[:title]
      }
    )
  end
end
