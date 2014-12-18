

$.Tabs = function (el) {
  this.$el = $(el);
  //this.$contentTabs = this.$el.find('a.active[href="www.google.com"]');//$("data-content-tabs");
  this.$contentTabs = $(this.$el.data( 'contentTabs' ));
  this.$active = this.$contentTabs.find('div.active');
  this.$el.on('click', 'a', (function () {
    this.clickTab(event);
  }).bind(this));
}

$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();
  this.$active.toggleClass('transitioning');
  this.$el.find('a.active').toggleClass( 'active' );

  this.$active.one('transitionend', (function() {
    this.$active.toggleClass("active");
    this.$active.toggleClass( 'transitioning' );
    $target = $(event.target).toggleClass( 'active' );
    this.$active = this.$contentTabs.find($target.attr( 'href' ))
                  .toggleClass( 'active' ).toggleClass( 'transitioning' );
                  
    setTimeout((function() {
      this.$active.toggleClass( 'transitioning' );
    }).bind(this), 0);
  }).bind(this));

}

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
