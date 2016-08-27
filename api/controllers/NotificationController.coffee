 # NotificationController
 #
 # @description :: Server-side logic for managing notifications
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers

module.exports =
  create: (req, res) ->
    # console.log "Notification", req.body
    Notification.create req.body, (err, notification) ->
      throw err if err
      return res.ok()
