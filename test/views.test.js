var request = require('supertest')

describe('Views', function() {

  describe('GET /', function() {
    it('should return 200', function(done){
      request(sails.hooks.http.app)
        .get('/')
        .expect(200, done)
    })
  })

  describe('GET /how', function() {
    it('should return 200', function(done){
      request(sails.hooks.http.app)
        .get('/how')
        .expect(200, done)
    })
  })

})
