SkyLib.Video = SkyLib.Video or class()
SkyLib.Video.CURRENT_PLAYLIST = {}

function SkyLib.Video:init()
    self:_init_panel()
end

function SkyLib.Video:_init_panel()
    self._full_workspace = managers.gui_data:create_fullscreen_workspace()
end


