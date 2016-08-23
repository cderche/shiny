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

  terms: (req, res) ->
    return res.view('terms')
    # if req.getLocale() == 'en'
      # return res.view('terms-en')
