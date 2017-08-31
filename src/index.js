'use strict';

require("./styles.scss");
import client from "./js/apollo/apollo.js";
import gql from 'graphql-tag';

var Elm = require('./Main');
var app = Elm.Main.fullscreen();

app.ports.queryUserAndSubReddit.subscribe(function () {
  client.query({
    query: gql`
      {
        reddit {
          user(username: "kn0thing") {
            username
            commentKarma
            createdISO
          }
          subreddit(name: "movies"){
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
      console.log(response.data.reddit)
      let reddit = response.data.reddit
      if (reddit.user) {
        console.log("Is user!")
        app.ports.setUser.send(reddit.user)
      }
      if (reddit.subreddit.newListings) {
        console.log("Is newListings!")
        app.ports.setNewListing.send(reddit.subreddit)
      }
    })
    .catch(error => console.log(error))
})