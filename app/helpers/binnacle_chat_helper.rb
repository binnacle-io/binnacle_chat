module BinnacleChatHelper
  def chat(options = {})
    options[:id] ||= "binnacle_chat"
    options[:room] ||= "binnacle_chat"
    render(
      partial: "binnacle_chat/binnacle_chat",
      locals: {
        binnacle_chat_id: options[:id],
        binnacle_chat_url: ENV["BINNACLE_URL"],
        binnacle_chat_account: ENV["BINNACLE_ACCOUNT"],
        binnacle_chat_app: ENV["BINNACLE_APP"],
        binnacle_chat_context: ENV["BINNACLE_CHAT_CTX"],
        binnacle_chat_api_key: ENV["BINNACLE_API_KEY"],
        binnacle_chat_api_secret: ENV["BINNACLE_API_SECRET"],
        binnacle_chat_room: options[:room],
        binnacle_chat_identity: options[:identity]
      }
    )
  end
end
