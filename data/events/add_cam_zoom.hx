function onEvent(_) {
	if (_.event.name == 'add_cam_zoom'&&FlxG.camera.zoom < 1.35) {
		var camZoom:Float = Std.parseFloat(_.event.params[0]);
		var hudZoom:Float = Std.parseFloat(_.event.params[1]);
		if(Math.isNaN(camZoom)) camZoom = 0.015;
		if(Math.isNaN(hudZoom)) hudZoom = 0.03;
		FlxG.camera.zoom += camZoom;
		camHUD.zoom += hudZoom;
	}
}