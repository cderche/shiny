module.exports = function(req, res, next) {
<<<<<<< HEAD
  // console.log('localize', req.getLocale());
  if ((req.cookies.preferredLanguage != req.getLocale()) && (req.cookies.preferredLanguage != null)) {
=======
  if (req.cookies.preferredLanguage && (req.cookies.preferredLanguage != req.getLocale()))
>>>>>>> master
    req.setLocale(req.cookies.preferredLanguage)
    // console.log('New locale', req.getLocale());
  }
  next()
};
