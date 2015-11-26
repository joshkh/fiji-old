'use strict'

mongoose = require 'mongoose'
Schema = mongoose.Schema

HolidaySchema = new Schema
  title: String
  date: type: Date, unique: true

module.exports = mongoose.model 'Holiday', HolidaySchema
