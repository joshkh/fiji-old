'use strict'

mongoose = require 'mongoose'
Schema = mongoose.Schema

AbsenceSchema = new Schema
  email: String
  comment: String
  from: Date
  to: Date
  days: [Date]
  reason: type: String, default: "Holiday"

module.exports = mongoose.model 'Absence', AbsenceSchema
