#= require jquery
#= require jquery-ui
#= require binnacle
#= require jspanel

$ ->
  if $('.binnacle_chat').length > 0
    binnacleData = $("body").data("binnacle-data")
    
    # configure jspanel
    binnacleChat = $.jsPanel
      title: binnacleData.room
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
      toolbarFooter: '<div id="binnacle-chat-footer"><a class="pull-left members" data-toggle="popover" data-placement="top" data-html="true" data-content="<ul><li>Room Member</li></ul>"><i class="fa fa-user"></i></a><form id="chat-form" class="form pull-right"><input id="message" type="text" class="form-control" placeholder="Type something…" /></form></div>'
      #bootstrap: 'danger'

    binnacleChat.content.append $('.binnacle_chat')
    
    $('.jsPanel').addClass 'panel-primary panel'
    
    #if minimalized, change footer position absolute to relative
    $('.jsPanel-btn-min').click ->
      $('.jsPanel #binnacle-chat-footer').css 'position', 'relative'
    
    #else change it back to absolute
    $('.jsPanel-btn-norm').click ->
      $('.jsPanel #binnacle-chat-footer').css 'position', 'absolute'
    
    client = null
    sessionId = Math.random().toString(36).substr(2)

    binnacleEventHandler = (event) ->
      $messages = $('#messages')

      if event.clientId == binnacleData.identity
        $message = $("#binnacle-chat-right").clone()
      else
        $message = $("#binnacle-chat-left").clone()

      $message.find('.message p').text(event.json.message)
      $message.find('.name').text(event.json.user)
      $message.find('.time span').text((new Date(event.eventTime)).toLocaleString())
      $message.removeAttr('id').removeClass('template')

      displayEvent($message)

    subscriberJoined = (event) ->
      $messages = $('#messages')
      activity = $('.user-joined.template').clone()
      activity.find('span').text(event.presenceId)
      activity.removeClass('template')

      displayEvent(activity)

      client && client.subscribers(displaySubscribers)

    subscriberLeft = (event) ->
      $messages = $('#messages')
      activity = $('.user-left.template').clone()
      activity.find('span').text(event.presenceId)
      activity.removeClass('template')

      displayEvent(activity)

      client && client.subscribers(displaySubscribers)

    $('#chat-form').submit (e) ->
      e.preventDefault()
      message = $('#message').val()
      return false unless message
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

    displayEvent = (event) ->
      $messages = $('#messages')
      $messages.append event

      $('.jsPanel-content').animate { scrollTop: $('.jsPanel-content').prop('scrollHeight') }, 500
      event.effect 'highlight', {}, 2000

    displaySubscribers = (subscribers, xhrData) ->
      subscribersList = "<ul>"
      subscribers.sort()
      for subscriber in subscribers
        subscribersList += "<li>#{subscriber}</li>"

      subscribersList += "</ul>"

      $('#binnacle-chat-footer .members').attr('data-content', subscribersList)

    client.subscribers(displaySubscribers)

  $('[data-toggle="popover"]').popover()
