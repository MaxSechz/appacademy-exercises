$.Thumbnails = function (el) {
  this.$el = $(el);
  this.$gutterImages = this.$el.find('.gutter-images');
  this.$activeImg = $(this.$gutterImages.children()[0]);
  this.activate(this.$activeImg);
  this.gutterIdx = 0;
  this.$images = this.$gutterImages.children();
  this.fillGutterImages();
  this.$gutterImages.on('mouseenter', 'img', this.mouseEnter.bind(this));
  this.$gutterImages.on('mouseleave', 'img', this.mouseLeave.bind(this));
}

$.Thumbnails.prototype.activate = function ($img) {
  var $clone = $img.clone();
  $(this.$gutterImages.parent().siblings()[0]).append($clone);
}

$.Thumbnails.prototype.fillGutterImages = function() {
  this.$gutterImages.children().remove();
  console.log(this.$gutterImages);
  for (var i = 0; i < this.gutterIdx + 5; i++) {
    this.$gutterImages.append(this.$images[i]);
  }
}
$.Thumbnails.prototype.mouseEnter = function (event) {
  var $target = $(event.currentTarget);
  this.$activeImg = $target;
}

$.Thumbnails.prototype.mouseLeave = function (event) {
  $($(this.$gutterImages.parent().siblings()[0]).children()[0]).remove();
  this.activate(this.$activeImg);
}

$.fn.thumbnails = function () {
  return this.each(function () {
    new $.Thumbnails(this);
  });
}
