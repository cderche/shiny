module.exports =

  statusUpdate: (newStatus, orderId, next) ->
    # console.log 'OrderService.statusUpdate'
    if newStatus == 't.processed'
      Order.findOne orderId, (err, order) ->
        EmailService.confirmation order, (err, res) ->
          # console.log 'OrderService.statusUpdate - completed'
          if err
            console.error err
          return next()
        return
    return
