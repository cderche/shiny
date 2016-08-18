module.controller 'StoreCtrl', [
  '$scope'
  'DataService'
  '$timeout'
  ($scope, DataService, $timeout) ->
    $scope.store  = DataService.store
    $scope.cart   = DataService.cart

    $scope.stateChanged = (sku) ->
      product = $scope.store.getProduct sku
      if $scope.cart.getTotalCount(sku) > 0
        $scope.cart.addItem(product.sku, product.name, product.desc, product.price, -9999)
      else
        $scope.cart.addItem(product.sku, product.name, product.desc, product.price, 1)
      return

    $scope.nextTab = (tabId, flag) ->
      if flag
        $timeout ->
          angular.element('ul.tabs').tabs 'select_tab', tabId
          return
        , 0
      return

    return
]

module.factory 'DataService', ->
  store = new Store()
  cart  = new Cart('shiny-cart')

  if cart.items.length <= 0
    # Set defaults
    item = store.getProduct 'BED'
    cart.addItem(item.sku, item.name, item.desc, item.price, 1)
    item = store.getProduct 'BAT'
    cart.addItem(item.sku, item.name, item.desc, item.price, 1)

    # i = 0
    # while i < store.products.length
    #   item = store.products[i]
    #   cart.addItem(item.sku, item.name, item.desc, item.price, 1)
    #   i++

  return {
    store:  store
    cart:   cart
  }
