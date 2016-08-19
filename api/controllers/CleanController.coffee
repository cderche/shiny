 # CleanController
 #
 # @description :: Server-side logic for managing cleans
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers

module.exports =
  clean: (req, res) ->
    # console.log 'render /clean', req.options.locals
    return res.view('clean')
