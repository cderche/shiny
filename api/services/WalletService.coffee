Payture     = require('payture')
api         = new Payture(process.env.PAYTURE_HOST)

ADD = process.env.PAYTURE_ADD
PAY = process.env.PAYTURE_PAY

module.exports =
  check: (data, cb) ->
    api.wallet.users.check ADD, data, (err, res) ->
      cb err, res
      return
    return
  register: (data, cb) ->
    api.wallet.users.register ADD, data, (err, res) ->
      cb err, res
      return
    return
  init: (data, cb) ->
    api.wallet.init ADD, data, (err, res) ->
      cb err, res
      return
    return
  getList: (data, cb) ->
    api.wallet.cards.getList ADD, data, (err, res) ->
      cb err, res
      return
    return
  pay: (data, cb) ->
    api.wallet.pay PAY, data, (err, res) ->
      cb err, res
      return
    return
  delete: (data, cb) ->
    api.wallet.users.delete ADD, data, (err, res) ->
      cb err, res
      return
    return
