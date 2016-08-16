module.exports = function(req, res, next) {
  console.log('req.cookies.preferredLanguage', req.cookies.preferredLanguage);
  console.log('req.getLocale()', req.getLocale());
  if (req.cookies.preferredLanguage && (req.cookies.preferredLanguage != req.getLocale())) {
    console.log('Before set');
    req.setLocale(req.cookies.preferredLanguage)
    console.log('After set');
  }
  next()
};
