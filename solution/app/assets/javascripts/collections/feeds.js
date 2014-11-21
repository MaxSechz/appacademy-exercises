NewReader.Collections.Feeds = Backbone.Collection.extend({
  model: NewReader.Models.Feed,
  url: 'api/feeds',

  getOrFetch: function(id) {
    var feedMaybe = this.get(id);
    if (!feedMaybe) {
      feedMaybe = new NewReader.Models.Feed({
        id: id
      });
      var that = this;
      feedMaybe.fetch({
        success: function() {
          that.add(feedMaybe);
        }
      });
    }
    return feedMaybe;
  },

  getOrFetchEntry: function (feedId, entryId) {
    var feedMaybe = this.get(entryId);
    var entry;
    if(feedMaybe) {
      entry = feedMaybe.entries().getOrFetch(entryId);
      return entry;
    }
    entry = new NewReader.Models.Entry({ id: entryId });
    entry.fetch();
    return entry;
  },
});
