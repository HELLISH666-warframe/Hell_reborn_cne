function onEvent(_) {
	if (_.event.name == 'add_cam_zoom') {
		var camZoom:Float = Std.parseFloat(_.event.params[0]);
		var hudZoom:Float = Std.parseFloat(_.event.params[1]);
		defaultCamZoom += camZoom;
		camHUD.zoom += hudZoom;
	}
}