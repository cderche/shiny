 # HomeController
 #
 # @description :: Server-side logic for managing Homes
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers

module.exports =

  home: (req, res) ->
    return res.view('homepage')

  public: (req, res) ->
    return res.view(req.url.substr(1))

  private: (req, res) ->
    return res.view(req.url.substr(1))
