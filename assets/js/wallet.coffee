# PAY CLASS - CONTAINS ALL PAYMENT DATA

Wallet = ->
  @cards = [
    { CardName: '1234XXXXXXX1324', CardHolder: 'John Doe' }
    { CardName: '9546XXXXXXX2343', CardHolder: 'Marie Jane' }
    { CardName: '2342XXXXXXX5493', CardHolder: 'Mark McCain' }
  ]
  # @fetchCards()
  return

Wallet::fetchCards = ->
  $.get '/wallet'
    .done (data) ->
      return next()
    .fail (err) ->
      console.error 'err', err
      return
  return

Wallet::hasCards = ->
  return @cards.length > 0
