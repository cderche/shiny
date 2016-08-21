var request;
var loginCookie;

request = require('supertest');
should = require('should')

describe('Order', function() {
  var loginUser, cart;

  loginUser = {
    email: 'order@test.com',
    password: 'password'
  };

  cartNoCard = {
    cart: {
      items: ['item1', 'item2'],
      schedule: {
        date: Date.now(),
        time: Date.now(),
        rule: {}
      },
      address: {},
      cardId: false
    }
  };

  cartCard = {
    cart: {
      items: ['item1', 'item2'],
      schedule: {
        date: Date.now(),
        time: Date.now(),
        rule: {}
      },
      address: {},
      cardId: "some-random-card-id"
    }
  };

  var users = []

  before(function(next) {
    User.create(loginUser, function(err, user) {
      if (err) {
        throw err;
      }
      users.push(user)
      request(sails.hooks.http.app)
        .post('/login')
        .send(loginUser)
        .end(function(err, res) {
          if (err) { throw err }
          loginCookie = res.headers['set-cookie']
          return next()
        });
    });
  });

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
  })

  describe('POST /order - Unauthenticated', function() {
    it('should return 401', function(done) {
      request(sails.hooks.http.app)
        .post('/order')
        .send(cartCard)
        .expect(401, done);
    });
  });

  describe('POST /order - Authenticated - (card_id = true)', function() {
    it('should redirect to /status', function(done) {
      request(sails.hooks.http.app)
        .post('/order')
        .set('Cookie', loginCookie)
        .send(cartCard)
        .expect(201, done);
    });
  });

  describe('POST /order - Authenticated - (card_id = false)', function() {
    it('should redirect to payture.com', function(done) {
      request(sails.hooks.http.app)
        .post('/order')
        .set('Cookie', loginCookie)
        .send(cartNoCard)
        .end(function(err, res) {
          console.log('res.headers',res.headers)
          res.headers.location.should.match(/^(https:\/\/sandbox2\.payture\.com)/)
          if (err) { throw err }
          done()
        })
    });
  });

});
