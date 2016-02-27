#= require jquery
#= require jquery-ui
#= require binnacle
#= require jspanel
#= require gravatarjs

$ ->
  if $('.binnacle_chat').length > 0
    identity = $('.binnacle_chat').data('identity')
    email = $('.binnacle_chat').data('email')
    displayName = $('.binnacle_chat').data('display-name')
    room = $('.binnacle_chat').data('room')
    id = $('.binnacle_chat').data('binnacle_chat_id')
    title = $('.binnacle_chat').data('title')

    # configure jspanel
    binnacleChat = $.jsPanel
      title: title
      position:
        top: (panel) ->
          $(window).height() - parseInt(panel.css('height'))
        right: "auto"
      offset: top: -10, left: 10
      bootstrap: 'default'
      iconfont: 'font-awesome'
      controls:
        buttons: 'none'
      id: id
      addClass:
        header: 'panel-heading'
        content: 'panel-body'
      overflow: 'scroll'
      size: width: '450px', height: '300px'

      # Pass footer toolbar so it won't scroll with the messages
      toolbarFooter: '<div id="binnacle-chat-footer"><a class="pull-left members" data-toggle="popover" data-placement="top" data-html="true" data-content="<ul><li>Room Member</li></ul>"><i class="fa fa-user"></i></a><form id="chat-form" class="form pull-right"><input id="message" type="text" class="form-control" placeholder="Type something…" /></form></div>'

    binnacleChat.content.append $('.binnacle_chat')

    $('.jsPanel').addClass 'panel-primary panel'

    #if minimized, change footer position absolute to relative
    $('.jsPanel-btn-min').click ->
      $('.jsPanel #binnacle-chat-footer').css 'position', 'relative'

    #else change it back to absolute
    $('.jsPanel-btn-norm').click ->
      $('.jsPanel #binnacle-chat-footer').css 'position', 'absolute'

    client = null
    sessionId = Math.random().toString(36).substr(2)

    binnacleEventHandler = (event) ->
      console.log("Received message! #{event}")
      $messages = $('#messages')

      if event.clientId == identity
        $message = $("#binnacle-chat-right").clone()
      else
        $message = $("#binnacle-chat-left").clone()

      $message.find('.message p').text(event.json.message)
      $message.find('.name').text(event.json.displayName)
      $message.find('.time span').text((new Date(event.eventTime)).toLocaleString())
      $message.removeAttr('id').removeClass('template')
      $message.find('.chat-user img').attr('src', gravatar(event.json.email))

      displayEvent($message)

    subscriberJoined = (event) ->
      if event.presenceId isnt client.options.identity
        $messages = $('#messages')
        activity = $('.user-joined.template').clone()
        activity.find('span').text(event.presenceId)
        activity.removeClass('template')

        displayEvent(activity)

        client && client.subscribers(displaySubscribers)

    subscriberLeft = (event) ->
      if event.presenceId isnt client.options.identity
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

      binnacleEvent = new (Binnacle.Event)(
        sessionId: sessionId
        eventName: room
        clientId: client.options.identity
        json:
          user: client.options.identity
          email: email
          displayName: displayName
          message: message
      )

      client.signal binnacleEvent
      $('#message').val ''

    client = new (Binnacle.Client)(
      apiKey: gon.apiKey
      apiSecret: gon.apiSecret
      endPoint: gon.endPoint
      contextId: gon.contextId
      missedMessages: true
      limit: 5
      since: 30
      identity: identity
      # filterBy: 'event'
      # filterByValue: room
      onSignal: binnacleEventHandler
      onSubscriberJoined: subscriberJoined
      onSubscriberLeft: subscriberLeft
    )

    client.subscribe()

    displayEvent = (event) ->
      $messages = $('#messages')
      $messages.append event
      event.removeClass('hidden')

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
