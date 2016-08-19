Payture     = require('payture')
api         = new Payture(process.env.PAYTURE_HOST)

merchantAdd = process.env.PAYTURE_ADD
merchantPay = process.env.PAYTURE_PAY

module.exports =
  check: (data, cb) ->
    api.wallet.users.check merchantAdd, data, (err, res) ->
      cb err, res
      return
    return
  register: (data, cb) ->
    api.wallet.users.register merchantAdd, data, (err, res) ->
      cb err, res
      return
    return
  init: (data, cb) ->
    api.wallet.init merchantAdd, data, (err, res) ->
      cb err, res
      return
    return
  getList: (data, cb) ->
    console.log 'WalletService.getList', data
    api.wallet.cards.getList merchantAdd, data, (err, res) ->
      console.log 'WalletService.getList - cb', res
      cb err, res
      return
    return
  pay: (data, cb) ->
    api.wallet.pay merchantPay, data, (err, res) ->
      console.log 'pay', res
      cb err, res
      return
    return
