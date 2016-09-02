module.controller 'StatusCtrl', [
  'DataService'
  (DataService) ->
    cart   = DataService.cart
    cart.clearCart = true
    return
]
