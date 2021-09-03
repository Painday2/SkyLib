EditorPlayVideo = EditorPlayVideo or class(MissionScriptEditor)
function EditorPlayVideo:create_element()
	self.super.create_element(self)
	self._element.class = "ElementPlayVideo"
end

function EditorPlayVideo:_build_panel()
	self:_create_panel()
	self:PathCtrl("movie", "movie", nil, nil, {help = "The movie's path, if it is not showing in the list, it is not loaded properly."})
	self:NumberCtrl("width", {floats = 0, help = "The movie's width, Defaults to 1280"})
	self:NumberCtrl("height", {floats = 0, help = "The movie's height, Defaults to 720"})
end
