# CART CLASS - CONTAINS THE PRODUCTS THE CUSTOMER WILL PURCHASE

Cart = (name) ->
  @name       = name
  @clearCart  = false
  @items      = []
  @schedule   = {}
  @address    = {}
  @cardId    = false
  # Load items from local storage
  @loadItems()
  @loadSchedule()
  @loadAddress()

  self = @
  $(window).unload ->
    if self.clearCart
      self.clearItems()
      self.clearSchedule()
      self.clearAddress()
    self.saveItems()
    self.saveSchedule()
    self.saveAddress()
    self.clearCart = false
    return
  return

Cart::loadSchedule = ->
  schedule = if localStorage isnt null then localStorage[@name + '_schedule'] else null
  if schedule and JSON
    try
      @schedule = JSON.parse schedule
  return

Cart::loadItems = ->
  items = if localStorage isnt null then localStorage[@name + '_items'] else null
  if items and JSON
    try
      items = JSON.parse items
      i = 0
      while i < items.length
        item = items[i]
        if item.sku and item.name and item.price and item.quantity
          item = new CartItem(item.sku, item.name, item.price, item.quantity)
          @items.push item
        i++
  return

Cart::loadAddress = ->
  address = if localStorage isnt null then localStorage[@name + '_address'] else null
  if address and JSON
    try
      @address = JSON.parse address
  return

Cart::saveSchedule = ->
  console.log 'saveSchedule'
  if localStorage and JSON
    localStorage[@name + '_schedule'] = JSON.stringify @schedule
    console.log 'localStorage["schedule"]', localStorage[@name + '_schedule']
  return

Cart::saveItems = ->
  if localStorage and JSON
    localStorage[@name + '_items'] = JSON.stringify @items
  return

Cart::saveAddress = ->
  if localStorage and JSON
    localStorage[@name + '_address'] = JSON.stringify @address
  return

Cart::setDate = (date) ->
  console.log 'setDate'
  @schedule.date = date
  @saveSchedule()
  return

Cart::setTime = (time) ->
  @schedule.time = time
  @saveSchedule()
  return

Cart::setRule = (rule) ->
  console.log 'setRule'
  @schedule.rule = rule
  @saveSchedule()
  return

Cart::addItem = (sku, name, desc, price, quantity) ->
  console.log 'Cart.addItem start'
  quantity = @toNumber quantity
  unless quantity is 0
    found = false
    i = 0
    while i < @items.length and !found
      item = @items[i]
      if item.sku is sku
        found = true
        item.quantity = @toNumber(item.quantity + quantity)
        if item.quantity <=0
          @items.splice i, 1
      i++
    unless found
      item = new CartItem(sku, name, price, quantity)
      @items.push item
    @saveItems()
  console.log 'Cart.addItem end'
  return

Cart::getTotalPrice = (sku) ->
  total = 0
  i = 0
  while i < @items.length
    item = @items[i]
    if not sku or item.sku is sku
      total += @toNumber item.quantity * item.price
    i++
  return total

Cart::getTotalCount = (sku) ->
  count = 0
  i = 0
  while i < @items.length
    item = @items[i]
    if not sku or item.sku is sku
      count += @toNumber item.quantity
    i++
  return count

Cart::clearItems = ->
  @items = []
  @saveItems()
  return

Cart::clearSchedule = ->
  @schedule = {}
  @saveSchedule()
  return

Cart::clearAddress = ->
  @address = {}
  @saveAddress()
  return

Cart::toNumber = (value) ->
  value = value * 1
  if isNaN(value) then 0 else value

Cart::getItem = (sku) ->
  i = 0
  while i < @items.length
    if @items[i].sku is sku
      return @items[i]
    i++
  null

Cart::getDuration = (sku) ->
  price = @getTotalPrice sku
  rate  = 700
  Math.round(price / rate * 2) / 2


Cart::getFinalPrice = (sku) ->
  price = @getTotalPrice sku
  return price * (1.0 - @schedule.rule.discount)

Cart::isMinAddress = ->
  return false if !@address
  a = @address.first_name  ||  false
  b = @address.last_name   ||  false
  c = @address.email       ||  false
  d = @address.telephone   ||  false
  e = @address.street      ||  false
  return a and b and c and d and e

Cart::isMinSchedule = ->
  return false if !@schedule
  a = @schedule.date || false
  b = @schedule.time || false
  c = @schedule.rule || false
  return a and b and c

Cart::isMinItems = ->
  return @items.length > 0

Cart::isCompleted = ->
  a = @isMinSchedule()
  b = @isMinAddress()
  c = @isMinItems()
  return a and b and c

Cart::submit = ->
  # @clearCart = true
  data = angular.toJson @
  $('#cart').val(data)
  $('form').submit()
  return

CartItem = (sku, name, price, quantity) ->
  @sku = sku
  @name = name
  @price = price * 1
  @quantity = quantity * 1
  return
