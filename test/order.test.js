var request   = require('supertest')
var should    = require('should')
var data      = require('./data')
var methods   = require('./methods')

describe('Order', function() {

  user    = null
  cookie  = null

  before(function(done) {
    async.waterfall([
      function(next) {
        // console.log('Create user.');
        User.create(data.user, function(err, u) {
          user = u
          next(err)
        })
      },
      function(next) {
        // console.log('Login user.');
        methods.login(data.user, function(err, c) {
          cookie = c
          next(err)
        })
      }
    ], function(err, res) {
      // console.log('Finish: before()');
      done()
    })
  })

  after(function(done) {
    async.series([
      function(next) {
        if (user) {
          User.destroy({ id: user.id }, function(err) {
            next(err)
          })
        }else{
          next()
        }
      }
    ], function(err, res) {
      // console.log('Finish: after()');
      done()
    })
  })

  describe('If POST /order as a Guest', function() {
    it('should redirect to /signin', function(done) {
      request(sails.hooks.http.app)
        .post('/order')
        .send(data.cart)
        .expect('location', '/signin')
        .end(done)
    })
  })

  describe('If POST /order as a Authenticated User', function() {

    describe('If order has a cardId', function() {
      it('should return status 201 Created', function(done) {
        var cart = data.cart
        cart.cart.cardId = 'ABCD-ABCD-ABCD-ABCD'
        request(sails.hooks.http.app)
          .post('/order')
          .set('Cookie', cookie)
          .send(cart)
          .expect(201, done)
      })
    })

    describe('If order has no cardId', function() {
      it('should redirect to payture.com', function(done) {
        var cart = data.cart
        cart.cart.cardId = false
        request(sails.hooks.http.app)
          .post('/order')
          .set('Cookie', cookie)
          .send(cart)
          .end(function(err, res) {
            res.headers.location.should.match(/^(https:\/\/sandbox2\.payture\.com)/)
            done()
          })
      })
    })
  })

});


// var loginUser, cart;

// loginUser = {
//   email: 'order@test.com',
//   password: 'password'
// };
//
// cartNoCard = {
//   cart: {
//     items: ['item1', 'item2'],
//     schedule: {
//       date: Date.now(),
//       time: Date.now(),
//       rule: {}
//     },
//     address: {},
//     cardId: false
//   }
// };
//
// cartCard = {
//   cart: {
//     items: ['item1', 'item2'],
//     schedule: {
//       date: Date.now(),
//       time: Date.now(),
//       rule: {}
//     },
//     address: {},
//     cardId: "some-random-card-id"
//   }
// };




  //   User.create(loginUser, function(err, user) {
  //     if (err) {
  //       throw err;
  //     }
  //     users.push(user)
  //     request(sails.hooks.http.app)
  //       .post('/login')
  //       .send(loginUser)
  //       .end(function(err, res) {
  //         if (err) { throw err }
  //         loginCookie = res.headers['set-cookie']
  //         return next()
  //       });
  //   });
  // });

  // after(function(next) {
  //   async.each(users, function(user, done) {
  //     User.destroy({id: user.id}).exec(function(err) {
  //       if (err) { console.error(err) }
  //       done()
  //     })
  //   }, function(err) {
  //     if (err) { console.error(err) }
  //     next()
  //   })
  // })

  //
  // describe('POST /order - Authenticated - (cardId = true)', function() {
  //   it('should redirect to /status', function(done) {
  //     request(sails.hooks.http.app)
  //       .post('/order')
  //       .set('Cookie', loginCookie)
  //       .send(cartCard)
  //       .expect(201, done);
  //   });
  // });
  //
  // describe('POST /order - Authenticated - (cardId = false)', function() {
  //   it('should redirect to payture.com', function(done) {
  //     request(sails.hooks.http.app)
  //       .post('/order')
  //       .set('Cookie', loginCookie)
  //       .send(cartNoCard)
  //       .end(function(err, res) {
  //         // console.log('res.headers',res.headers)
  //         res.headers.location.should.match(/^(https:\/\/sandbox2\.payture\.com)/)
  //         if (err) { throw err }
  //         done()
  //       })
  //   });
  // });
