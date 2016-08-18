# STORE CLASS - CONTAINS ALL PRODUCTS

Store = ->
  @products = [
    new Product('LIV', 't.liv', 't.liv_desc', 500)
    new Product('KIT', 't.kit', 't.kit_desc', 500)
    new Product('BED', 't.bed', 't.bed_desc', 500)
    new Product('BAT', 't.bat', 't.bat_desc', 500)
    new Product('WIN', 't.win', 't.win_desc', 100)
    new Product('IRO', 't.iro', 't.iro_desc', 50)
  ]
  return

Store::getProduct = (sku) ->
  i = 0
  while i < @products.length
    if @products[i].sku == sku
      return @products[i]
    i++
  null
