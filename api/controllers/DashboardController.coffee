module.exports =

  dashboard: (req, res) ->
    # console.log 'res.locals.user', res.locals.user
    return res.view('dashboard')
