module.exports = (req, res, next) ->
  # if req.isSocket
  #   if req.session and req.session.passport and req.session.passport.user
  #     #Use this:
  #     # Initialize Passport
  #     sails.config.passport.initialize() req, res, ->
  #       # Use the built-in sessions
  #       sails.config.passport.session() req, res, ->
  #         # Make the user available throughout the frontend
  #         res.locals.user = req.user;
  #         #the user should be deserialized by passport now;
  #         return next()
  #       return
  #     #Or this if you dont care about deserializing the user:
  #     #req.user = req.session.passport.user;
  #     #return next();
  #   else
  #     res.json 401
  # console.log 'isAuthenticated', req.isAuthenticated()
  if req.isAuthenticated()
    return next()
  return res.redirect('signin')
