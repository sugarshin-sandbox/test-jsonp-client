Promise = require 'bluebird'
jsonp = require 'jsonp-client'
# request = require 'superagent'



URLs = [
  'http://marks-contents.s3.amazonaws.com/universal/jsonp/new_release.jsonp?callback=new_release'
  'http://marks-contents.s3.amazonaws.com/universal/jsonp/2000drama_youth.jsonp?callback=drama_youth2000'
  'http://marks-contents.s3.amazonaws.com/universal/jsonp/1990drama_youth.jsonp?callback=drama_youth1990'
  'http://marks-contents.s3.amazonaws.com/universal/jsonp/1980drama_youth.jsonp?callback=drama_youth1980'
  'http://marks-contents.s3.amazonaws.com/universal/jsonp/1970drama_youth.jsonp?callback=drama_youth1970'
  'http://marks-contents.s3.amazonaws.com/universal/jsonp/1960drama_youth.jsonp?callback=drama_youth1960'
  'http://marks-contents.s3.amazonaws.com/universal/jsonp/1950drama_youth.jsonp?callback=drama_youth1950'
]

addCallback = (url) ->
  return url if url.match /callback=[a-z]/i
  return "#{url}#{("&callback=cb#{Math.random()}").replace('.', '')}"

getJSONP = (url) ->
  new Promise (resolve, reject) ->
    jsonp addCallback(url), (err, date) ->
      if err?
        reject err
      else
        resolve date

getJSONPAll = (urlList) ->
  promises = (getJSONP(url) for url, i in urlList)# when i isnt 10)
  new Promise.all promises

getJSONPAll URLs
  .then (data) -> console.log data
  .catch (err) -> console.warn err
