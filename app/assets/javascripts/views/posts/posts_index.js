Journal.Views.PostsIndex = Backbone.View.extend({

  events: {
    "click .delete": "deletePost"
  },

  template: JST['posts/index'],

  initialize: function() {
    this.listenTo(this.collection, "destroy", this.render);
    this.listenTo(this.collection, "add", this.render);
    this.listenTo(this.collection, "change:title", this.render);
    this.listenTo(this.collection, "remove", this.render);
    this.listenTo(this.collection, "reset", this.render);
  },

  render: function () {
    var content = this.template({posts: this.collection});
    this.$el.html(content);
    return this;
  },

  deletePost: function (event) {
    event.preventDefault();
    var postId = $(event.target).data("id");
    var post = this.collection.get(postId);
    post.destroy();
  }

});
