NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: "api/feeds",
  model: NewsReader.Models.Feed,

  getOrFetch: function(id) {
    var newModel = new NewsReader.Models.Feed();
    newModel.set({id: id});
    if (!this.get(id)) {
      var currentCollection = this;
      newModel.fetch({
        success: function() {
          currentCollection.add(newModel);
        }
      });
    } else {
      this.get(id).fetch();
    }

    return this.get(id) || newModel;
  }
});
