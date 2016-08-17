var request = require('supertest')

describe('Auth', function() {

  var loginUser = { email: 'login@test.com', password: 'password' }
  var signupUser = { email: 'signup@test.com', password: 'password' }

  before(function(next) {
    User.create(loginUser, function(err, user) {
      if (err) { console.error(err) }
      console.log(`Created ${user.email}`);
      next()
    })
  })

  after(function(next) {
    User.destroy().exec(function(err) {
      if (err) { console.error(err) }
      next()
    })
  })

  describe('POST /login', function() {
    it('should return 200', function(done){
      request(sails.hooks.http.app)
        .post('/login')
        .send(loginUser)
        .expect(200, done)
    })
  })

  describe('POST /user', function() {
    it('should return 200', function(done){
      request(sails.hooks.http.app)
        .post('/user')
        .send(signupUser)
        .expect(201, done)
    })
  })



})
