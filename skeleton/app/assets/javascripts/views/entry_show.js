NewsReader.Views.EntryShow = Backbone.View.extend({
  template: JST['entries/entry_show'],
  tagName: "ul",
  render: function() {
    var content = this.template({entry: this.model});
    this.$el.html(content);
    return this;
  }
})
