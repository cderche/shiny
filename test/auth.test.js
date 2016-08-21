var request = require('supertest')
var async = require('async')

describe('Auth', function() {

  var users = []
  var loginUser = { email: 'login@test.com', password: 'password' }
  var signupUser = { email: 'signup@test.com', password: 'password' }

  before(function(next) {
    User.create(loginUser, function(err, user) {
      if (err) { console.error(err) }
      console.log(`Created ${user.email}`);
      users.push(user)
      next()
    })
    // return next()
  })

  after(function(next) {
    async.each(users, function(user, done) {
      User.destroy({id: user.id}).exec(function(err) {
        if (err) { console.error(err) }
        done()
      })
    }, function(err) {
      if (err) { console.error(err) }
      next()
    })
    // return next()
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
    it('should return 201', function(done){
      request(sails.hooks.http.app)
        .post('/user')
        .send(signupUser)
        .expect(201)
        .end(function(err, res) {
          users.push(res.body)
          done()
        })
    })
  })

  describe('GET /signin', function() {
    it('should return 200', function(done){
      request(sails.hooks.http.app)
        .get('/signin')
        .expect(200, done)
    })
  })

  describe('GET /signup', function() {
    it('should return 200', function(done){
      request(sails.hooks.http.app)
        .get('/signup')
        .expect(200, done)
    })
  })
})
