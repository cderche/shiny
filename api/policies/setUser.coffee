module.exports = (req, res, next) ->
  console.log 'setUser()', req.user
  if req.user
    req.options.locals = req.options.locals or {}
    req.options.locals.user = req.user
  return next()
