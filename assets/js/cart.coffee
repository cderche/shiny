# CART CLASS - CONTAINS THE PRODUCTS THE CUSTOMER WILL PURCHASE

Cart = (name) ->
  @name   = name
  @clear  = false
  @items  = []
  @schedule = {}
  # Load items from local storage
  @loadItems()
  @loadSchedule()

  self = @
  $(window).unload ->
    if self.clear
      self.clearItems()
      self.clearSchedule()
    self.saveItems()
    self.saveSchedule()
    self.clearCart = false
    return
  return

Cart::loadSchedule = ->
  # schedule = if localStorage isnt null then localStorage[@name + '_schedule'] else null
  # if schedule and JSON
  #   try
  #     @schedule = JSON.parse schedule
  # return

Cart::loadItems = ->
  # items = if localStorage isnt null then localStorage[@name + '_items'] else null
  # if items and JSON
  #   try
  #     items = JSON.parse items
  #     i = 0
  #     while i < items.length
  #       item = items[i]
  #       if item.sku and item.name and item.price and item.quantity
  #         item = new CartItem(item.sku, item.name, item.price, item.quantity)
  #         @items.push item
  # return

Cart::saveSchedule = ->
  if localStorage and JSON
    localStorage[@name + '_schedule'] = JSON.stringify @schedule
  return

Cart::saveItems = ->
  if localStorage and JSON
    localStorage[@name + '_items'] = JSON.stringify @items
  return

Cart::setDate = (date) ->
  @schedule.date = date
  @saveSchedule()
  return

Cart::setTime = (time) ->
  @schedule.time = time
  @saveSchedule()
  return

Cart::setRule = (rule) ->
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
  @item = []
  @saveItems()
  return

Cart::clearSchedule = ->
  @schedule = {}
  @saveSchedule()
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


CartItem = (sku, name, price, quantity) ->
  @sku = sku
  @name = name
  @price = price * 1
  @quantity = quantity * 1
  return
