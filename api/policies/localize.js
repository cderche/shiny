module.exports = function(req, res, next) {

  if (req.cookies.preferredLanguage) {
    req.setLocale(req.cookies.preferredLanguage)
  }

  next()
};
