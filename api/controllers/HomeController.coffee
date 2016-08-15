 # HomeController
 #
 # @description :: Server-side logic for managing Homes
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers

module.exports =

  home: (req, res) ->
    return res.render('homepage')

  page: (req, res) ->
    return res.render(req.url.substr(1))
