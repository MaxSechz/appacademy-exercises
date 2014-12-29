Journal.Routers.Posts = Backbone.Router.extend({
  routes: {
    "": "postsIndex",
    "posts/new": "postForm",
    "posts/:id": "postShow"
  },

  initialize: function (options) {
    this.$sidebar = options.$sidebar;
    this.$content = options.$content;
    this._postsCollection = new Journal.Collections.Posts();
    this._postsCollection.fetch();
    this.postsIndex();
  },

  postsIndex: function() {
    this.$content.empty();
    var postsIndex = new Journal.Views.PostsIndex({collection: this._postsCollection});
    this.$sidebar.html(postsIndex.render().$el);
  },

  postShow: function(id) {
    var post = this._postsCollection.getOrFetch(id);
    var postShow = new Journal.Views.PostShow({collection: this._postsCollection, model: post});
    this.$content.html(postShow.render().$el);
  },

  postForm: function() {
    var post = new Journal.Models.Post();
    var postForm = new Journal.Views.PostForm({model: post, collection: this._postsCollection});
    this.$content.html(postForm.render({title: "", body: "", errors: {}}).$el);
  }
});
