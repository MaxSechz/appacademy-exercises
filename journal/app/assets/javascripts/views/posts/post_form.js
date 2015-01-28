Journal.Views.PostForm = Backbone.View.extend({
  template: JST['posts/form'],

  events: {
    "submit": "createPost"
  },

  createPost: function(event) {
    event.preventDefault();
    var params = $(event.target).serializeJSON().post;

    this.model.save(params, {
      success: function() {
        this.collection.add(this.model, {merge: true});
        Backbone.history.navigate('', {trigger: true});
      }.bind(this),

      error: function(model, res) {
        var params = model.attributes;
        params.errors = res.responseJSON;
        this.render(params);
      }.bind(this)
    })
  },

  render: function(params) {
    var content = this.template(params);
    this.$el.html(content);
    return this;
  }
})
