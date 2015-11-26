'use strict'

_ = require 'lodash'
Holiday = require './holiday.model'

# Get list of holidays
exports.index = (req, res) ->
  Holiday.find (err, holidays) ->
    return handleError res, err  if err
    res.status(200).json holidays

# Get a single holiday
exports.show = (req, res) ->
  Holiday.findById req.params.id, (err, holiday) ->
    return handleError res, err  if err
    return res.status(404).send 'Not Found'  if not holiday
    res.json holiday

# Creates a new holiday in the DB.
exports.create = (req, res) ->
  Holiday.create req.body, (err, holiday) ->
    return handleError res, err  if err
    res.status(201).json holiday

# Updates an existing holiday in the DB.
exports.update = (req, res) ->
  delete req.body._id  if req.body._id
  Holiday.findById req.params.id, (err, holiday) ->
    return handleError res, err  if err
    return res.status(404).send 'Not Found'  if not holiday
    updated = _.merge holiday, req.body
    updated.save (err) ->
      return handleError res, err  if err
      res.status(200).json holiday

# Deletes a holiday from the DB.
exports.destroy = (req, res) ->
  Holiday.findById req.params.id, (err, holiday) ->
    return handleError res, err  if err
    return res.status(404).send 'Not Found'  if not holiday
    holiday.remove (err) ->
      return handleError res, err  if err
      res.status(204).send 'No Content'

handleError = (res, err) ->
  res.status(500).send err
