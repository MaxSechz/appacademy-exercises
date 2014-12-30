NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST['feeds/feed_show'],

  events: {
    "click .refresh": "refreshEntries"
  },

  initialize: function(){
    this.listenTo(this.model, 'sync', this.render)
  },

  render: function(){
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    var currentView = this;
    console.log(this.model.entries());
    this.model.entries().each(function(entry) {
      var entryView = new NewsReader.Views.EntryShow({model: entry});
      currentView.$(".entry[data-id=" + entry.id + "]").append(entryView.render().$el)
    });
    return this;
  },

  refreshEntries: function(event) {
    event.preventDefault();
    this.model.fetch();
  }
});
