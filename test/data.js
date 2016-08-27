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
NOTIFICATION_ADD = {
  OrderId: 'ABCD', // Must be set
  SessionType: 'Block',
  WUserLgn: USER.email,
  VWUserPsw: 'ABCD', // Must be set
  Amount: '100',
  CardHolder: 'User Name',
  IsAlfa: 'False',
  CardName: '411111xxxxxx1111',
  CardId: 'd14e7aaa-4658-45dd-a4da-91cdf00918c0',
  CardNumber: '411111xxxxxx1111',
  DateTime: '636079113333222187',
  Success: 'True',
  Notification: 'CustomerAddSuccess',
  MerchantContract: 'VWMerchantGetshinyAdd'
}

module.exports = {

  user:             USER,
  order:            ORDER,
  cart:             CART,
  notificationAdd:  NOTIFICATION_ADD

}
