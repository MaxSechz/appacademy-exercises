NewsReader.Views.FeedIndex = Backbone.View.extend({
  template: JST['feeds/feed_index'],

  events: {
    "click .destroy": "deleteFeed"
  },

  initialize: function() {
    this.listenTo(this.collection, "sync destroy", this.render);
  },

  render: function(){
    var content = this.template({ feeds: this.collection });
    this.$el.html(content);
    return this;
  },

  deleteFeed: function(event) {
    event.preventDefault();
    var feedId = $(event.currentTarget).data("id");
    var model = this.collection.get(feedId);
    var currentView = this;
    model.destroy();
  }
});
