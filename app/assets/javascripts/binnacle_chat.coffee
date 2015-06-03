#= require jquery
#= require jquery-ui
#= require binnacle
#= require jspanel

$(document).ready ->  

  $ ->
    $('[data-toggle="popover"]').popover()
    
  if $('.binnacle_chat').length > 0
    binnacleData = $("body").data("binnacle")
    
    # configure jspanel
    binnacleChat = $.jsPanel
      title: 'Room name'
      position: 'bottom right'
      iconfont: 'font-awesome'
      controls: 
          iconfont: 'font-awesome'
          smallify: 'false'
      id: 'jsPanel-1'
      addClass:
          header: 'panel-heading'
          content: 'panel-body'
      overflow: 'scroll'
      size: width: '450px', height: '300px'
      
      # Pass footer toolbar so it won't scroll with the messages
      toolbarFooter: '<div id="footer"><a class="pull-left members" data-toggle="popover" data-placement="top" data-html="true" data-content="<ul><li>Batman</li><li>Room member</li><li>Superman</li></ul>"><i class="fa fa-user"></i></a><form class="form pull-right"><input id="message" type="text" class="form-control" placeholder="Type something…" /></form></div>'
      #bootstrap: 'danger'

    binnacleChat.content.append $('.binnacle_chat')
    
    $('.jsPanel').addClass 'panel-primary panel'
    
    #if minimalized, change footer position absolute to relative
    $('.jsPanel-btn-min').click ->
      $('.jsPanel #footer').css 'position', 'relative'
    
    #else change it back to absolute
    $('.jsPanel-btn-norm').click ->
      $('.jsPanel #footer').css 'position', 'absolute'
    
    #
    client = null
    sessionId = Math.random().toString(36).substr(2)

    binnacleEventHandler = (event) ->
      $messages = $('#messages')
      $message = $("""<div class="alert alert-success"><i class="icon-user"></i> #{event.json.user}:#{event.json.message}</div>""")
      $messages.append $message
      $messages.animate { scrollTop: $messages.prop('scrollHeight') }, 500
      $('#messages div:last-child').effect 'highlight', {}, 2000

    subscriberJoined = (event) ->
      console.log 'subscriber joined: ' + event

    subscriberLeft = (event) ->
      console.log 'subscriber left: ' + event

    $('#chat-form').submit (e) ->
      e.preventDefault()
      message = $('#message').val()
      room = $('input[name=\'room\']').val()
      binnacleEvent = new (Binnacle.Event)(
        sessionId: sessionId
        eventName: binnacleData.room
        clientId: client.options.identity
        json:
          user: client.options.identity
          message: message)
      client.signal binnacleEvent
      $('#message').val ''

    client = new (Binnacle.Client)(
      accountId: binnacleData.accountId
      appId: binnacleData.appId
      apiKey: binnacleData.apiKey
      apiSecret: binnacleData.apiSecret
      endPoint: binnacleData.endPoint
      contextId: binnacleData.contextId
      missedMessages: true
      limit: 5
      since: 30
      identity: binnacleData.identity
      filterBy: 'event'
      filterByValue: binnacleData.room
      onSignal: binnacleEventHandler
      onSubscriberJoined: subscriberJoined
      onSubscriberLeft: subscriberLeft
    )

    client.subscribe()
