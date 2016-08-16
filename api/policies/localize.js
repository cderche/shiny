module.exports = function(req, res, next) {
  console.log('req.cookies.preferredLanguage', req.cookies.preferredLanguage);
  console.log('req.getLocale()', req.getLocale());
  if (req.cookies.preferredLanguage != req.getLocale())
    req.setLocale(req.cookies.preferredLanguage)
  next()
};
