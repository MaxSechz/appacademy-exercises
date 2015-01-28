Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit form": "savePokemon"
  },

  render: function () {
    this.$el.append(JST['pokemonForm']({}));
  },

  savePokemon: function (event) {
    event.preventDefault();
    var savingPokemans = $(event.currentTarget).serializeJSON();
    console.log(savingPokemans.pokemon);
    this.collection.create(savingPokemans.pokemon, {
      success: function (model) {
        Backbone.history.navigate("pokemon/" + model.id, {trigger: true});
        this.collection.trigger('newpoke')
      }.bind(this)
    });
  }
});
