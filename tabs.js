

$.Tabs = function (el) {
  this.$el = $(el);
  //this.$contentTabs = this.$el.find('a.active[href="www.google.com"]');//$("data-content-tabs");
  console.log(this.$el);
  this.$contentTabs = $(this.$el.data( 'contentTabs' ));
  console.log(this.$contentTabs);
  this.$active = this.$contentTabs.find('div.active');
  console.log(this.$active);
  this.$el.on('click', 'a', (function () {
    this.clickTab(event);
  }).bind(this));
}

$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();
  this.$active.toggleClass("active");
  this.$el.find('a.active').toggleClass( 'active' );
  console.log(event);
  $target = $(event.target).toggleClass( 'active' );
  var newActive = $($target.context.hash).toggleClass("active");
  this.$active = newActive;
}

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
