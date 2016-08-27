var request   = require('supertest')
var should    = require('should')
// var assert    = require('chai').assert
var async     = require('async')

var data = require('./data')

describe('POST /notification', function() {

  var user          = null
  var order         = null
  var notification  = null
  var prevCount     = null

  before(function(done) {
    // console.log('Start: before()');
    async.waterfall([
      function(next) {
        // console.log('Create user');
        User.create(data.user, function(err, u) {
          user = u
          data.notificationAdd.VWUserPsw = u.payture_token
          next(err)
        })
      },
      function(next) {
        // console.log('Create order');
        data.order.user = user.id
        Order.create(data.order, function(err, o) {
          order = o
          data.notificationAdd.OrderId = o.id
          next(err)
        })
      },
      function(next) {
        // console.log('Count notifications');
        Notification.count({}, function(err, count){
          prevCount = count
          next(err)
        })
      }
    ], function (err, result) {
      // console.log('End: before()');
      done()
    })
  })

  after(function(done) {
    // console.log('Start: after()');
    async.series([
      function(next) {
        if (user) {
          User.destroy({ id: user.id }, function(err) {
            next(err)
          })
        }else{
          next()
        }
      },
      function(next) {
        if (order) {
          Order.destroy({ id: order.id }, function(err) {
            next(err)
          })
        }else{
          next()
        }
      },
      function(next) {
        if (notification) {
          Notification.destroy({ id: notification.id }, function(err) {
            next(err)
          })
        }else{
          next()
        }
      }
    ], function(err, res) {
      // console.log('End: after()');
      done()
    })
  })

  it('Should return status 200 OK', function(done) {
    request(sails.hooks.http.app)
      .post('/notification')
      .send(data.notificationAdd)
      .expect(200, done)
  })

  it('Should create a new notification', function(done) {
    Notification.count({}).exec(function(err, count){
      if (err) { throw err }
      count.should.equal(prevCount+1)
      done()
    })
  })

  it('Should add a cardId to the order', function(done) {
    Order.findOne({ id: data.notificationAdd.OrderId }, function(err, order) {
      order.cardId.should.equal(data.notificationAdd.CardId)
      done()
    })
  })

})
