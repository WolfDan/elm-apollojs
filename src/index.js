'use strict';

require("./styles.scss");
import client from "./js/apollo/apollo.js";
import gql from 'graphql-tag';

var Elm = require('./Main');
var app = Elm.Main.fullscreen();

app.ports.queryUserAndSubReddit.subscribe(function (keyValue) {
  var [username, subredditName] = keyValue
  client.query({
    query: gql`
      {
        reddit {
          user(username: "${username}") {
            username
            commentKarma
            createdISO
          }
          subreddit(name: "${subredditName}"){
            newListings(limit: 2) {
              title
              comments {
                body
                author { 
                  username
                  commentKarma
                }
              }
            }
          }
        }
      }
    `
  })
    .then(response => {
      let reddit = response.data.reddit
      if (reddit.user) {
        app.ports.setUser.send(reddit.user)
      }
      if (reddit.subreddit.newListings) {
        app.ports.setNewListing.send(reddit.subreddit)
      }
    })
    .catch(error => console.log(error))
})