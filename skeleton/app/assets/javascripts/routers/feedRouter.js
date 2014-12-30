NewsReader.Routers.FeedRouter = Backbone.Router.extend({
  routes: {
    "" : "feedIndex",
    "feeds/new" : "feedForm",
    "feeds/:id" : "feedShow"
  },

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    this.collection = options.collection;
    this.collection.fetch();
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  },

  feedIndex: function (){
    var indexView = new NewsReader.Views.FeedIndex({collection: this.collection});
    this._swapView(indexView);
  },

  feedShow: function (id){
    var feed = this.collection.getOrFetch(id);
    var showView = new NewsReader.Views.FeedShow({model: feed});
    this._swapView(showView);
  },

  feedForm: function (){
    var form = new NewsReader.Views.FeedForm({ model: new NewsReader.Models.Feed(), collection: this.collection });
    this._swapView(form);
  }
});
