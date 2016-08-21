var cust = [
  'user@test.com',
  'signup@test.com',
  'login@test.com',
  'order@test.com'
]

var Payture = require('payture')
var api = new Payture(process.env.PAYTURE_HOST)

for (var i = 0; i < cust.length; i++) {
  var data = {
    'VWUserLgn': cust[i],
    'Password': process.env.PAYTURE_PASSWORD
  }

  api.wallet.users.delete(process.env.PAYTURE_ADD, data, function(err, res) {
    if (err) {
      console.error(err);
    }
    console.log(res);
  })
}
