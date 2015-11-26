'use strict'

_ = require 'lodash'
moment = require 'moment'
mrange = require 'moment-range'
Absence = require './absence.model'
Holiday = require '../holiday/holiday.model'

# Get list of absences
exports.index = (req, res) ->
  Absence.find (err, absences) ->
    return handleError res, err  if err
    res.status(200).json absences

# Get a single absence
exports.show = (req, res) ->
  Absence.findById req.params.id, (err, absence) ->
    return handleError res, err  if err
    return res.status(404).send 'Not Found'  if not absence
    res.json absence

# Creates a new absence in the DB.
exports.create = (req, res) ->

  # Add the user to the request
  req.body.email = req.user.email

  from = req.body.from
  to = req.body.to

  range = moment.range moment(from), moment(to)

  days = []

  range.by 'd', (moment) ->
    if moment.isoWeekday() != 6 and moment.isoWeekday() != 7
      console.log moment.toDate()
      days.push moment.toDate()

  console.log "days without weekends is", days.length

  Holiday.where('date').in(days).select('title').then (found, er) ->

    if found? then console.log "FOUND IS", found
    if er? then console.log "ERROR IS", err



    if !found?
      req.body.workdays = days.length
    else
      req.body.workdays = days.length - found.length

    console.log "got all the way to here"

    Absence.create req.body, (err, absence) ->
      console.log "req is", req.body
      return handleError res, err  if err
      res.status(201).json absence



# Updates an existing absence in the DB.
exports.update = (req, res) ->
  delete req.body._id  if req.body._id
  Absence.findById req.params.id, (err, absence) ->
    return handleError res, err  if err
    return res.status(404).send 'Not Found'  if not absence
    updated = _.merge absence, req.body
    updated.save (err) ->
      return handleError res, err  if err
      res.status(200).json absence

# Deletes a absence from the DB.
exports.destroy = (req, res) ->
  Absence.findById req.params.id, (err, absence) ->
    return handleError res, err  if err
    return res.status(404).send 'Not Found'  if not absence
    absence.remove (err) ->
      return handleError res, err  if err
      res.status(204).send 'No Content'

handleError = (res, err) ->
  res.status(500).send err
