'use strict'

express = require 'express'
controller = require './absence.controller'
auth = require '../../auth/auth.service'

router = express.Router()

router.get '/', controller.index
router.get '/:id', controller.show
router.post '/', auth.isAuthenticated(), controller.create
router.put '/:id', controller.update
router.patch '/:id', controller.update
router.delete '/:id', controller.destroy

module.exports = router
