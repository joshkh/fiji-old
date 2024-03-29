'use strict'

should = require 'should'
app = require '../../app'
request = require 'supertest'

describe 'GET /api/holidays', ->

  it 'should respond with JSON array', (done) ->
    request(app)
      .get('/api/holidays')
      .expect(200)
      .expect('Content-Type', /json/)
      .end (err, res) ->
        return done err  if err
        res.body.should.be.instanceof Array
        done()
