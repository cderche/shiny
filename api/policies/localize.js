module.exports = function(req, res, next) {
  // console.log('localize')
  if (req.cookies.preferredLanguage && (req.cookies.preferredLanguage != req.getLocale()))
    req.setLocale(req.cookies.preferredLanguage)
    // console.log('localize', req.getLocale())
  return next()
};
