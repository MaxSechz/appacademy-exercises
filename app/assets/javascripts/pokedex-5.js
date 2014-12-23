Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  initialize: function () {
    // this.collection = new Pokedex.Collections.Pokemon();
    this.listenTo(this.collection, "newpoke", this.refreshPokemon);
  },

  addPokemonToList: function (pokemon) {
    this.$el.append(JST['pokemonListItem']({pokemon: pokemon}));
  },

  refreshPokemon: function (options, callback) {
    this.collection.fetch({
      success: function() {
        console.log(callback)
        callback && callback();
        this.render();
      }.bind(this)
    });
  },

  render: function () {
    this.$el.empty();
    this.collection.forEach(this.addPokemonToList.bind(this));
  },

  selectPokemonFromList: function (event) {
    var $target = $(event.currentTarget);
    var targetModel = $target.data('id');
    Backbone.history.navigate("/pokemon/" + targetModel, {trigger: true});
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li": "selectToyFromList"
  },

  refreshPokemon: function (options, callback) {
    this.model.fetch({
      success: function() {
        callback && callback();
        this.render();
      }.bind(this)
    });
  },

  render: function () {
    this.$el.append(JST['pokemonDetail']({pokemon: this.model}));
    this.model.toys().forEach(function(toy) {
      var toyEl = JST['toyListItem']({toy: toy});
      this.$("ul.toys").append(toyEl);
    }.bind(this))
  },

  selectToyFromList: function (event) {
    var $target = $(event.currentTarget);
    var targetId = $target.data('id');
    Backbone.history.navigate("pokemon/" + this.model.id + "/toys/" + targetId, {trigger: true});
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    this.$el.append(JST['toyDetail']({toy: this.model, pokes: []}));
  }
});

// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
