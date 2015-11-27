moment = require 'moment'

getCurrentRange = ->
  moment [moment().year(), 9, 31]


console.log getCurrentRange().toDate()
