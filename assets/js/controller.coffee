module.controller 'StoreCtrl', [
  '$scope'
  'DataService'
  '$timeout'
  '$cookies'
  ($scope, DataService, $timeout, $cookies) ->
    $scope.store  = DataService.store
    $scope.cart   = DataService.cart
    $scope.wallet = DataService.wallet

    $scope.stateChanged = (sku) ->
      product = $scope.store.getProduct sku
      if $scope.cart.getTotalCount(sku) > 0
        $scope.cart.addItem(product.sku, product.name, product.desc, product.price, -9999)
      else
        $scope.cart.addItem(product.sku, product.name, product.desc, product.price, 1)
      return

    $scope.nextTab = (event, tabId, policy) ->
      event.preventDefault()
      event.stopPropagation()
      # console.log 'nextTab', tabId
      if policy
        $timeout ->
          angular.element('ul.tabs').tabs 'select_tab', tabId
          return
        , 0
      return

    initdp = ->
      min = moment().add(2, 'days').toDate()
      sel = moment($scope.cart.schedule.date).toDate()
      i18n = $cookies.get('preferredLanguage')

      if i18n == 'ru'
        $('.datepicker').pickadate
          selectMonths: false
          selectYears: false
          today: ''
          monthsFull: ['января','февраля','марта','апреля','мая','июня','июля','августа','сентября','октября','ноября','декабря']
          monthsShort: ['янв','фев','мар','апр','май','июн','июл','авг','сен','окт','ноя','дек']
          weekdaysFull: ['воскресенье','понедельник','вторник','среда','четверг','пятница','суббота']
          weekdaysShort: ['вс','пн','вт','ср','чт','пт','сб']
          clear: ''
          close: 'закрыть'
          firstDay: 1
          format: 'd mmmm yyyy г.'
          formatSubmit: 'yyyy/mm/dd'
          onStart: ->
            @set 'min', min
            @set 'select', sel
            return
          onSet: (context) ->
            try
              # toISOString()
              $scope.cart.setDate(moment(context.select).toDate())
              if !$scope.$$phase
                $scope.$apply()
            return
      else
        $('.datepicker').pickadate
          selectMonths: false
          selectYears: false
          today: ''
          onStart: ->
            @set 'min', min
            @set 'select', sel
            return
          onSet: (context) ->
            try
              # toISOString()
              $scope.cart.setDate(moment(context.select).toDate())
              if !$scope.$$phase
                $scope.$apply()
            return
      return

    inittp = ->
      base = moment($scope.cart.schedule.time).format('HH:mm')
      console.log 'base', base
      $('.timepicker').pickatime
        twelvehour: false
        default: base
        # donetext: 'OK'
      .change ->
        try
          $scope.cart.schedule.time = moment(@value, 'h:ma').toDate()
          if !$scope.$$phase
            $scope.$apply()
        return
      return

    initdp()
    inittp()

    return
]

module.factory 'DataService', ->
  store   = new Store()
  cart    = new Cart('shiny-cart')
  wallet  = new Wallet()

  if cart.items.length <= 0
    # Set defaults
    item = store.getProduct 'BED'
    cart.addItem(item.sku, item.name, item.desc, item.price, 1)
    item = store.getProduct 'BAT'
    cart.addItem(item.sku, item.name, item.desc, item.price, 1)
    item = store.getProduct 'LIV'
    cart.addItem(item.sku, item.name, item.desc, item.price, 1)
    item = store.getProduct 'KIT'
    cart.addItem(item.sku, item.name, item.desc, item.price, 1)

  min = moment().add(2, 'days').toDate()
  cart.schedule.date = cart.schedule.date || min
  cart.schedule.rule = cart.schedule.rule || store.getRule(0)
  cart.schedule.time = cart.schedule.time || moment('10:00am', 'h:ma').toDate()


  return {
    store:  store
    cart:   cart
    wallet: wallet
  }
