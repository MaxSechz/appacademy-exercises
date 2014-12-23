Pokedex.Router = Backbone.Router.extend({
  routes: {
    '': 'pokemonIndex',
    'pokemon/:id': "pokemonDetail",
    'pokemon/:pokemonId/toys/:toyId': "toyDetail"
  },

  pokemonDetail: function (id, callback) {
    if (this._pokemonIndex) {
      var targetModel = this._pokemonIndex.collection.get(id);
      this._pokemonDetail = new Pokedex.Views.PokemonDetail({model: targetModel});
      $("#pokedex .pokemon-detail").html(this._pokemonDetail.$el);
      this._pokemonDetail.refreshPokemon({}, callback);
    } else {
      this.pokemonIndex(this.pokemonDetail.bind(this, id, callback));
    }
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex({collection: new Pokedex.Collections.Pokemon()});
    this._pokemonIndex.refreshPokemon({}, callback);
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {
    if (this._pokemonDetail) {
      var toy = this._pokemonDetail.model.toys().get(toyId);
      var toyDetail = new Pokedex.Views.ToyDetail({model: toy});
      $("#pokedex .toy-detail").html(toyDetail.$el);
      toyDetail.render();
    } else {
      this.pokemonDetail(pokemonId, this.toyDetail.bind(this, pokemonId, toyId));
    }
  },

  pokemonForm: function () {
    var pokeFormView = new Pokedex.Views.PokemonForm({model: new Pokedex.Models.Pokemon(), collection: this._pokemonIndex.collection});
    pokeFormView.render();
    $("#pokedex .pokemon-form").html(pokeFormView.$el);
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
