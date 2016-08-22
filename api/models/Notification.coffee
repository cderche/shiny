 # Notification.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models

CustomerAddSuccess = 'CustomerAddSuccess'


module.exports =

  attributes: {}

  beforeCreate: (data, next) ->
    # Update order to contain cardId
    if data.Notification == CustomerAddSuccess
      if data.OrderId and data.CardId
        Order.update { id: data.OrderId }, { cardId: data.CardId }
          .exec (err, update) ->
            throw err if err
            return next()
        return
      else
        return next()
    else
      return next()
