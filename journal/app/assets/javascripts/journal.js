window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    alert('Fuck off from Backbone!');
    var router = new Journal.Routers.Posts({$sidebar: $("div.sidebar"), $content: $("div.content")});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  Journal.initialize();
});
