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
