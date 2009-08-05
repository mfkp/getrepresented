window.addEvent('domready', function(){
	$('tabs-nav').getElements('li').each(function(i) {
		i.addEvent('click', function(event){
			event.stop();
			Tab(i.get('id'));
		});
	});
});
function Tab(key){
	$('tabs-nav').getElements('li').each(function(i) {
		i.removeClass('active');
	})
	$(key).addClass('active');
	
	//$(key + '-loading').set('html', '<img src=\'img/ajax-loader.gif\' width=\'16\' height=\'16\' alt=\'Loading\' />');
	
	//$(key + '-loading').set('html','');
	//$('tabs-content').set('html','hello');
	
	if (key == 'tab-1') {
		document.getElementById('questions-content').style.display = 'block';
		document.getElementById('ideas-content').style.display = 'none';
		document.getElementById('problems-content').style.display = 'none';
		document.getElementById('praise-content').style.display = 'none';
	}
	if (key == 'tab-2') {
		document.getElementById('questions-content').style.display = 'none';
		document.getElementById('ideas-content').style.display = 'block';
		document.getElementById('problems-content').style.display = 'none';
		document.getElementById('praise-content').style.display = 'none';
	}
	if (key == 'tab-3') {
		document.getElementById('questions-content').style.display = 'none';
		document.getElementById('ideas-content').style.display = 'none';
		document.getElementById('problems-content').style.display = 'block';
		document.getElementById('praise-content').style.display = 'none';
	}
	if (key == 'tab-4') {
		document.getElementById('questions-content').style.display = 'none';
		document.getElementById('ideas-content').style.display = 'none';
		document.getElementById('problems-content').style.display = 'none';
		document.getElementById('praise-content').style.display = 'block';
	}
	
	
}