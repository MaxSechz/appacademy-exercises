$.Carousel = function (el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.$active = $(this.$el.find(".items").children()[this.activeIdx]).addClass("active");
  this.$el.find('.slide-left').on('click', this.slideLeft.bind(this));
  this.$el.find('.slide-right').on('click', this.slideRight.bind(this));
  this.transitioning = false;
};

$.Carousel.prototype.slide = function (dir, dirClass) {
  if (this.transitioning) {
    return;
  } else {
    this.transitioning = true;
  }

  var oppDirection = dirClass === 'right' ? 'left' : 'right'
  this.$active.addClass(oppDirection);

  var oldActive = this.$active;

  this.$active.one('transitionend', (function() {
    oldActive.removeClass("active");
    oldActive.removeClass(oppDirection);
    this.transitioning = false;
  }).bind(this))

  var itemsLength = this.$el.find(".items").children().length;
  this.activeIdx = (this.activeIdx + dir + itemsLength) % itemsLength;

  this.$active = $(this.$el.find(".items").children()[this.activeIdx])
  this.$active.addClass(dirClass).addClass('active');

  setTimeout((function() {
    console.log(this.$active);
    this.$active.removeClass(dirClass);
  }).bind(this), 0);

};

$.Carousel.prototype.slideLeft = function() {
  this.slide(-1, 'left');
}

$.Carousel.prototype.slideRight = function() {
  this.slide(1, 'right');
}



$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
