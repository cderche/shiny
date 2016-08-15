module.exports = function(req, res, next) {
  if (req.cookies.preferredLanguage != req.getLocale())
    req.setLocale(req.cookies.preferredLanguage)
  next()
};
