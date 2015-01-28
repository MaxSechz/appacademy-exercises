Journal.Collections.Posts = Backbone.Collection.extend({
  url: 'posts/',
  model: Journal.Models.Post,

  getOrFetch: function (id) {
    var posts = this;

    var post;
    if (!(post = this.get(id))) {
      post = new Journal.Models.Post({id: id});
      post.fetch({
        success: function () {
          posts.add(post);
        }
      });
    }

    return post;
  }
});
