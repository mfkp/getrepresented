window.addEvent('domready', function(){
	if (document.getElementById('tabs-nav')) {
		$('tabs-nav').getElements('li').each(function(i){
			i.addEvent('click', function(event){
				event.stop();
				Tab(i.get('id'));
			});
		});
	};
});
function Tab(key){
	$('tabs-nav').getElements('li').each(function(i) {
		i.removeClass('active');
	})
	$(key).addClass('active');
	
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