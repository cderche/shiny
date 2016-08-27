module.exports =
  CustomerPaySuccess: (data, next) ->
    if data.OrderId and data.CardId
      return next()
    else
      console.error 'CustomerPaySuccess Error', data
      return next()
    return

  CustomerAddSuccess: (data, next) ->
    if data.OrderId and data.CardId
      Order.update { id: data.OrderId }, { cardId: data.CardId }
        .exec (err, update) ->
          throw err if err
          return next()
      return
    else
      console.error 'CustomerAddSuccess Error', data
      return next()

  CustomerRefundSuccess: (data, next) ->
    console.log "Not Implemented"
    return next()
