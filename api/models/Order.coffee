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
    status:
      type: 'string'
      defaultsTo: 't.open'

    getItem: (sku, next) ->
      value = null
      async.each @items, (item, done) ->
        if item.sku == sku
          value = item
        done()
      , (err) ->
        throw err if err
        if value
          return next(value)
        return next()
      return

  beforeUpdate: (data, next) ->
    # console.log 'Order.beforeUpdate
    if data.status
      OrderService.statusUpdate data.status, data.id, (err, res) ->
        return next()
      return
    else
      return next()

  # afterCreate: (record, next) ->
  #   # console.log "record.id", record.id
  #   try
  #     Order.findOne record.id, (err, order) ->
  #       EmailService.confirmation order, (err, res) ->
  #         if err
  #           throw err
  #         return
  #       return
  #   catch err
  #     console.error err
  #   return next()
