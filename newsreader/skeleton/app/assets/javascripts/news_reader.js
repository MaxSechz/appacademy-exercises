window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // alert('Hello from Backbone!');
    NewsReader.collection = new NewsReader.Collections.Feeds();
    var router = new NewsReader.Routers.FeedRouter({
      collection: NewsReader.collection,
      $rootEl: $("div#content")
      });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
