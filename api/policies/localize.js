module.exports = function(req, res, next) {
  // console.log('localize', req.getLocale());
  if ((req.cookies.preferredLanguage != req.getLocale()) && (req.cookies.preferredLanguage != null)) {
    req.setLocale(req.cookies.preferredLanguage)
    // console.log('New locale', req.getLocale());
  }
  next()
};
