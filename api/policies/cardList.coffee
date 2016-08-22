module.exports = (req, res, next) ->
  # console.log 'wallet'

  payload =
    VWUserLgn:  req.user.email
    VWUserPsw:  req.user.payture_token

  try
    WalletService.getList payload, (err, data) ->
      # console.log 'Policy.Wallet', err, data
      if err
        throw err

      typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'
      if typeIsArray data.GetList.Item
        req.options.locals = req.options.locals or {}
        req.options.locals.cards = res.GetList.Item
      return next()
  catch error
    console.error error
    return next()
  return
