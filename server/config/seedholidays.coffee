###*
Populate DB with sample data on server start
to disable, edit config/environment/index.js, and set `seedDB: false`
###

'use strict'


Holiday = require '../api/holiday/holiday.model'

request = require 'request'

url = 'http://www.gov.uk/bank-holidays.json'

request {url: url, json: true}, (err, res, body) ->

  holidays = body["england-and-wales"].events

  Holiday.find({}).remove ->
    Holiday.create holidays
