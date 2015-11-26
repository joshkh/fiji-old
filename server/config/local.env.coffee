'use strict'

# Use local.env.js for environment variables that grunt will set when the server starts locally.
# Use for your api keys, secrets, etc. This file should not be tracked by git.
#
# You will need to set these on the server you deploy to.

module.exports =
  DOMAIN: 'http://localhost:9000'
  SESSION_SECRET: "fiji-secret"

  GOOGLE_ID: "909038004492-ksv9g5lclm5jofdpnosjr3ee9hakg3or.apps.googleusercontent.com"
  GOOGLE_SECRET: 'oFJQl67kCC2oUQuSAzMZnnnF'


  # Control debug level for modules using visionmedia/debug
  DEBUG: ''
