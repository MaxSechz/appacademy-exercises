NewsReader.Views.FeedForm = Backbone.View.extend({
  template: JST["feeds/feed_form"],
  events: {
    "submit" : "makeFeed"
  },
  tagName: "form class='new-feed'",
  render: function(){
    var formContent = this.template({feed: this.model});
    this.$el.html(formContent);
    return this;
  },
  makeFeed: function(event){
    event.preventDefault();
    var $form = $(event.currentTarget);
    console.log($form)
    var jsonForm = $form.serializeJSON().feed;
    console.log(jsonForm);
    var currentView = this;
    this.collection.create(jsonForm, {
      success: function(model){
        Backbone.history.navigate("feeds/" + model.id, {trigger: true});
      },
      error: function(model) {
        currentView.model = model;
        currentView.render();
      }
    });
  }
});
