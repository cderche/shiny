USER  = { email: 'user@test.com', password: 'password' }
ORDER = {
  items: [
    {
      sku : "BED",
      name : "t.bed",
      price : 500,
      quantity : 1
    },
    {
      sku : "BAT",
      name : "t.bat",
      price : 400,
      quantity : 1
    },
    {
      sku : "LIV",
      name : "t.liv",
      price : 500,
      quantity : 1
    },
    {
      sku : "KIT",
      name : "t.kit",
      price : 500,
      quantity : 1
    }
  ],
  schedule: {
    date: Date.now(),
    time: Date.now(),
    rule: {
      id : 0,
      name : "t.once",
      discount : 0
    }
  },
  address: {
    email: USER.email,
    first_name : "User",
    last_name : "Example",
    telephone : "123",
    street : "ABC Street",
    house : "1",
    apartment : "7",
    note : "Notes, notes, notes..."
  },
  cardId: false
}
CART  = {
  cart: ORDER
}
NOTIFICATION = {
  'Notification': 'CustomerAddSuccess',
  'PhoneNumber':  '123456789',
  'VWUserLgn':    USER.email,
  'CardName':     'John Doe',
  'CardId':       '15227c4a-d352-4191-8c3d-b331e9a9e57d',
  'Success':      'True',
}

module.exports = {

  user:           USER,
  order:          ORDER,
  cart:           CART,
  notification:   NOTIFICATION

}
