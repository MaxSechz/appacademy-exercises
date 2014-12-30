NewsReader.Views.FeedForm = Backbone.View.extend({
  template: JST["feeds/feed_form"],
  events: {
    "submit" : "makeFeed"
  },
  tagName: "form",
  className: "new-feed",
  render: function(){
    var formContent = this.template({feed: this.model});
    this.$el.html(formContent);
    return this;
  },
  makeFeed: function(event){
    event.preventDefault();
    var $form = $(event.currentTarget);
    var jsonForm = $form.serializeJSON().feed;
    var currentView = this;
    this.collection.create(jsonForm, {
      success: function(model){
        Backbone.history.navigate("feeds/" + model.id, {trigger: true});
      },
      error: function(model, resp) {
        currentView.model = model;
        currentView.render();
      }
    });
  }
});
