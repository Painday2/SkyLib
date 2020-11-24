SkyLib.Sound = SkyLib.Sound or class()

function SkyLib.Sound:init()
    self._xaudio_initialized = false
    self._sound_buffers = {}
    self._sound_sources = {}

    if not SkyLib._project_key then
        log("[SkyLibSound] Project data doesn't have a global key...")
        return
    else
        log("Global Key found. Testing modpath: " .. SkyLib._project_key.ModPath)
    end

    self:_init_xaudio()
end

function SkyLib.Sound:_init_xaudio()
    if not XAudio then
        log("You don't have SuperBLT installed. XAudio will not work!")
        return
    end

    blt.xaudio.setup()
    self._xaudio_initialized = true

    log("XAudio initialized and ready to use.")
end

function SkyLib.Sound:play(data)
    if not self._xaudio_initialized then
        return
    end

    if not self._sound_sources[data.name] then
        table.insert(self._sound_buffers, data.name)
        table.insert(self._sound_sources, data.name)
    end

    if self._sound_sources[data.name] then
        self._sound_buffers[data.name]:close()
        self._sound_sources[data.name]:close()
        self._sound_sources[data.name] = nil
    end

    local directory = ""

    if data.custom_dir and data.custom_dir ~= "" then
        directory = data.custom_dir .. "/"
    end

    if data.custom_package and data.custom_package ~= "" then
        package = data.custom_package .. "/"
    else
        package = "assets/"
    end

    self._sound_buffers[data.name] = XAudio.Buffer:new(SkyLib.ModPath .. package .. directory .. data.file_name)
    self._sound_sources[data.name] = XAudio.Source:new(self._sound_buffers[data.name])

    if not data.sound_type then
        data.sound_type = "sfx"
    end

    self._sound_sources[data.name]:set_type(data.sound_type)
    self._sound_sources[data.name]:set_relative(data.is_relative)
    self._sound_sources[data.name]:set_looping(data.is_loop)

    if data.is_3d then
        self._sound_sources[data.name]:set_position(data.position)
    end

    if data.use_velocity then
        self._sound_sources[data.name]:set_velocity(data.position)
    end

    if data.override_volume and data.override_volume > 0 then
        if data.override_volume > 1 then
            data.override_volume = 1
        end

        self._sound_sources[data.name]:set_volume(data.override_volume)
    end
end

function SkyLib.Sound:_get_mod_path()
    if not SkyLib._project_key then
        return
    end

    return SkyLib._project_key.ModPath
end