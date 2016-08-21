# STORE CLASS - CONTAINS ALL PRODUCTS

Store = ->
  @products = [
    new Product('LIV', 't.liv', 't.liv_desc', 500)
    new Product('KIT', 't.kit', 't.kit_desc', 500)
    new Product('BED', 't.bed', 't.bed_desc', 500)
    new Product('BAT', 't.bat', 't.bat_desc', 400)
    new Product('WIN', 't.win', 't.win_desc', 100)
    new Product('IRO', 't.iro', 't.iro_desc', 50)
  ]
  @rules = [
    { id: 0, name: 't.once',    discount: 0.0   }
    { id: 1, name: 't.month',   discount: 0.05  }
    { id: 2, name: 't.2weeks',  discount: 0.1   }
    { id: 3, name: 't.weekly',  discount: 0.2   }
  ]
  return

Store::getProduct = (sku) ->
  i = 0
  while i < @products.length
    if @products[i].sku == sku
      return @products[i]
    i++
  null

Store::getRule = (id) ->
  id = @toNumber(id)
  i = 0
  while i < @rules.length
    if @rules[i].id == id
      return @rules[i]
    i++
  null

Store::getDiscount = (id) ->
  id = @toNumber(id)
  i = 0
  while i < @rules.length
    if @rules[i].id == id
      return 1.0 - @rules[i].discount
    i++
  null

Store::toNumber = (value) ->
  value = value * 1
  if isNaN(value) then 0 else value
