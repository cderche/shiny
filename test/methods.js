var request = require('supertest');
var data    = require('./data')

module.exports = {
  login: function(data, next) {
    request(sails.hooks.http.app)
      .post('/login')
      .send(data)
      .end(function(err, res) {
        var cookie = res.headers['set-cookie']
        // console.log('Set-Cookie', cookie)
        next(err, cookie)
      });
  }
}
