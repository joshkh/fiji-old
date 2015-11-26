'use strict'

mongoose = require 'mongoose'
Schema = mongoose.Schema

AllowanceSchema = new Schema
  email: String
  info: String
  active: Boolean

module.exports = mongoose.model 'Allowance', AllowanceSchema
