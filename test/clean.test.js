var request = require('supertest')

var loginCookie

describe('Clean', function() {

  activeUser = { email: 'user@example.com', password: 'password' }

  before(function(next) {
    User.create(activeUser, function(err, user) {
      if (err) { throw err }
      console.log(`Created ${user.email}`);

      request(sails.hooks.http.app)
        .post('/login')
        .send(activeUser)
        .end(function(err, res) {
          if (err) { throw err }
          loginCookie = res.headers['set-cookie']
          next()
        })
    })
  })

  after(function(next) {
    User.destroy().exec(function(err) {
      if (err) { console.error(err) }
      next()
    })
  })

  describe('GET /clean - Guest', function() {
    it('should redirect to /signin', function(done){
      request(sails.hooks.http.app)
        .get('/clean')
        .expect('location', '/signin')
        .expect(302)
        .end(done)
    })
  })

  describe('GET /clean - User', function() {
    it('should go to /clean', function(done){
      request(sails.hooks.http.app)
        .get('/clean')
        .set('Cookie', loginCookie)
        .expect(200, done)
    })
  })

})
