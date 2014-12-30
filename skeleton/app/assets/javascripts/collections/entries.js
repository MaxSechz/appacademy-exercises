NewsReader.Collections.Entries = Backbone.Collection.extend({
  url: function() {
    return this.feed.url() + '/entries';
  },

  initialize: function (attrs, options) {
    this.feed = options.feed;
  }
});
