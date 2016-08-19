 # OrderController
 #
 # @description :: Server-side logic for managing orders
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers

module.exports =

  create: (req, res) ->
    console.log 'req.body', req.body
    res.send 'ok'
