 # Order.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models

module.exports =

  attributes:
    items:
      type: 'array'
    schedule:
      type: 'json'
    address:
      type: 'json'
    cardId:
      type: 'string'
    user:
      model: 'user'
    total_item_price:
      type: 'float'
    total_price:
      type: 'float'

    getItem: (sku, next) ->
      for item in @items
        if item.sku == sku
          return next(sku)
      return

  afterCreate: (order, next) ->
    try
      EmailService.confirmation order, (err, res) ->
        if err
          throw err
        return
    catch err
      console.error err
    return next()
