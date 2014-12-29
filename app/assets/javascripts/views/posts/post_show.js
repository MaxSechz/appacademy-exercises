Journal.Views.PostShow = Backbone.View.extend({
  template: JST['posts/show'],
  bodyTemplate: JST['posts/_body'],
  titleTemplate: JST['posts/_title'],

  events: {
    "dblclick .post": "editPost",
    "blur .post": "updatePost"
  },

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  },

  editPost: function (event) {
    var $target = $(event.target);
    if ($target.hasClass("title")) {
      var content = this.titleTemplate({title: this.model.get('title')});
      $target.html(content);
      $target.find("input").focus();
    } else if ($target.hasClass("body")) {
      var content = this.bodyTemplate({title: this.model.get('body')});
      $target.html(content);
      $target.find("textarea").focus();
    }
  },

  updatePost: function (event) {
    var $input = $(event.target);
    var data = $input.serializeJSON();
    this.model.save(data, {
      success: function() {
        this.collection.add(this.model, { merge: true });
        this.render();
      }.bind(this),

      error: function(model, res) {
        var $error = $(".error").empty();
        var errors = res.responseJSON;
        $("span.title").text(errors.title);
        $("span.body").text(errors.body);
      },

      patch: true});
  }
});
