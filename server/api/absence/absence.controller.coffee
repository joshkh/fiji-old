# 'use strict'

_ = require 'lodash'
moment = require 'moment'
mrange = require 'moment-range'
Absence = require './absence.model'
Holiday = require '../holiday/holiday.model'
Q = require 'q'

# Get list of absences
exports.index = (req, res) ->
  Absence.find (err, absences) ->
    return handleError res, err  if err

    absences = _.map absences, (absence) -> absence.toJSON()

    # Promise to get all holidays that fall within our absences
    promises = (Holiday.where('date').in(absence.days) for absence in absences)

    Q.all(promises).then (resolved) ->

      # Join all of our holidays together in one array
      holidays = [].concat.apply [], resolved
      absences = _.each absences, (absence) ->

        absence.workdays = []

        # Walk through each day and remove weekends and holidays
        _.each absence.days, (day) ->

          isvalid = true

          # Remove weekends
          if moment(day).isoWeekday() == 6 or moment(day).isoWeekday() == 7
            isvalid = false

          # Remove holidays
          _.each holidays, (holiday) ->
            if holiday.date.toString() == day.toString()
              isvalid = false

          if isvalid then absence.workdays.push day

      res.status(200).json absences


# Get list of absences
exports.test = (req, res) ->

  # Fetch all absences associate with this user's email address
  Absence.find {email: req.user.email}, 'days', (err, absences) ->
    return handleError res, err  if err

    # Create a range for the academic year
    range = moment.range moment([req.params.year - 1, 9, 31]), moment([req.params.year, 9, 31])

    # Get all days taken off as Moments
    days = _.map (_.flatten _.pluck absences, 'days'), (d) -> moment d

    # Dsicard days outside of the academic range
    days = _.filter days, (day) -> range.contains day

    # Remove holidays and weekends
    Holiday.where().then (holidays, err) ->

      # Fetch our holidays as Moments
      holidays = _.map holidays, (holiday) -> moment(holiday.date)

      # Discard holidays that fall outside the academic range
      holidays = _.filter holidays, (holiday) -> range.contains holiday

      # Set the moments to midnight
      holidays = _.map holidays, (holiday) -> holiday.hour(0)

      # Convert to strings because Date objects are annoying as hell.
      holidays = _.map holidays, (holiday) -> holiday.toString()

      # Remove holidays from the days taken off
      days = _.filter days, (day) -> return day if not _.contains holidays, day.toString()

      # Remove weekends
      days = _.filter days, (day) -> return day if day.isoWeekday() not in [6, 7]

      res.status(200).json days


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

  req.body.days = []

  range.by 'd', (moment) ->
    req.body.days.push moment.toDate()

  Absence.create req.body, (err, absence) ->
    return handleError res, err  if err
    res.status(201).json absence

    # if moment.isoWeekday() != 6 and moment.isoWeekday() != 7
    #   console.log moment.toDate()
    #   days.push moment.toDate()
  #
  # Holiday.where('date').in(days).select('title').then (found, er) ->
  #
  #   if found? then console.log "FOUND IS", found
  #   if er? then console.log "ERROR IS", err
  #
  #
  #
  #   if !found?
  #     req.body.workdays = days.length
  #   else
  #     req.body.workdays = days.length - found.length
  #
  #   console.log "got all the way to here"



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
