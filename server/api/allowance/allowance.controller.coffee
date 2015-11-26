'use strict'

_ = require 'lodash'
Allowance = require './allowance.model'

# Get list of allowances
exports.index = (req, res) ->
  console.log "req is", req.params
  Allowance.find (err, allowances) ->
    return handleError res, err  if err
    res.status(200).json allowances

# Get a single allowance
exports.show = (req, res) ->
  console.log req.body
  Allowance.findById req.params.id, (err, allowance) ->
    return handleError res, err  if err
    return res.status(404).send 'Not Found'  if not allowance
    res.json allowance

# Creates a new allowance in the DB.
exports.create = (req, res) ->
  Allowance.create req.body, (err, allowance) ->
    return handleError res, err  if err
    res.status(201).json allowance

# Updates an existing allowance in the DB.
exports.update = (req, res) ->
  delete req.body._id  if req.body._id
  Allowance.findById req.params.id, (err, allowance) ->
    return handleError res, err  if err
    return res.status(404).send 'Not Found'  if not allowance
    updated = _.merge allowance, req.body
    updated.save (err) ->
      return handleError res, err  if err
      res.status(200).json allowance

# Deletes a allowance from the DB.
exports.destroy = (req, res) ->
  Allowance.findById req.params.id, (err, allowance) ->
    return handleError res, err  if err
    return res.status(404).send 'Not Found'  if not allowance
    allowance.remove (err) ->
      return handleError res, err  if err
      res.status(204).send 'No Content'

handleError = (res, err) ->
  res.status(500).send err
