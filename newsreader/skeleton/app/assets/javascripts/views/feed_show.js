NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST['feeds/feed_show'],
  events: {
    "click .refresh": "refreshEntries"
  },

  initialize: function(){
    this.listenTo(this.model, 'sync', this.render);
    this.subviews = []
  },

  render: function(){
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    var currentView = this;
    this.model.entries().each(function(entry) {
      console.log(entry);
      var entryView = new NewsReader.Views.EntryShow({model: entry})
      currentView.subviews.push(entryView);
      currentView.$("ul.content").append(entryView.render().$el)
    });
    return this;
  },

  refreshEntries: function(event) {
    event.preventDefault();
    this.model.fetch();
  },

  remove: function(){
    this.subviews.forEach(function(subview){
      subview.remove()
    });
    Backbone.View.prototype.remove.call(this);
  }
});
