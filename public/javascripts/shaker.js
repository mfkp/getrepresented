/* shake baby! */
window.addEvent('domready',function() {
	var shaker = $('shaker');
	shaker.setStyles({
		opacity: 0,
		display: 'block'
	});
	/* event */
	window.addEvent('load',function() {
		/* fade in */
		var x = function() { shaker.fade('in');};
		x.delay(1000);
		/* shake */
		var y = function() { shaker.shake('margin',5,3); };
		y.delay(3000); /* shake once faded in */
		y.periodical(15000); /* then shake every 15 seconds */
	});
});