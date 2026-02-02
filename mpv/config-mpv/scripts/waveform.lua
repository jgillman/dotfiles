--[[
  * waveform.lua v.2022-07-27
  * BASED ON detuur and microraptor's histogram script.
  * AUTHORS: detuur, microraptor, sotomonte
  * License: MIT
  * link: https://github.com/detuur/mpv-scripts
  * 
  * This script exposes a configurable way to overlay ffmpeg
  * waveforms in mpv.
  * 
  * There are three default keybinds:
  *     c - Toggle the waveform on/off
  *     C - Cycle between the waveform types
  *     Alt+c - Change the histogram's color
  * These keybinds can be changed by placing the following lines
  * in your input.conf:
  *     KEY script-binding toggle-waveform
  *     KEY script-binding cycle-waveform-type
  *     KEY script-binding toggle-waveform-position
  *
  * This script does *not* support config files, because of the nested
  * options. Please edit the options directly in the `opts` array
  * below.
--]]

local opts = {
    -- These options directly control the `waveform` filter in ffmpeg, consult
    -- its options at this link: https://ffmpeg.org/ffmpeg-filters.html#waveform
    opacity=0.9,
    defaultWavePos = "up",
    pixel_fmt = "lowpass",
    -- As a rule of thumb, pixel formats with an 'a' allow for transparency and look
    -- prettier, but are also slower, which is why the higher bit-depths have alpha-
    -- less formats. Get a full list of supported and unsupported formats by running
    -- mpv with `mpv --vf=format=fmt=help` on the command line.
    fmts_available = { "lowpass", "acolor", "color" },
    -- If this option is true and the script detects hardware decoding is used, it
    -- automatically disables it, when the waveform is toggled on. Once the
    -- waveform is toggled off again, the previous hardware decoding setting is
    -- restored. This is necessary, because the waveform video filter will most
    -- likely not work with hardware decoding.
    disable_hwdec = true
}

--/!\ DO NOT EDIT BELOW THIS LINE /!\

local mp = require 'mp'
local msg = require 'mp.msg'

local fa_ri = {}    -- Reverse index of fmts_available
local hwdec = nil   -- Used to store hardware decoding property


function buildGraph()
    local y
    if (opts.defaultWavePos == "down") then
        y = "H-h"
    else
        y = "W-w"
    end
    return "split=2[a][b],[b]waveform=filter="
    ..(opts.pixel_fmt)
    ..":bgopacity="
    ..opts.opacity
    ..",format=yuva444p[hh],[a][hh]overlay=x=0:y="..y
    --with no customization: return "split=2[a][b],[b]waveform=filter=acolor:bgopacity=0.7,format=yuva444p[hh],[a][hh]overlay=x=0:y=H-h-0"
end

function toggleFilter()
    -- iterate video filters and look for a waveform
    local video_filters = mp.get_property_native("vf")
    for _, filter in pairs(video_filters) do
        if filter["label"] == "waveform" then
            -- waveform found, remove it
            mp.command("no-osd vf remove @waveform")
            msg.info("Removed the waveform video filter")
            -- restore hardware decoding
            if hwdec and hwdec ~= "no" then
                mp.set_property("hwdec", hwdec)
                msg.info("Restored hardware decoding setting: " .. hwdec)
                mp.osd_message("Restored hardware decoding setting: " .. hwdec, 2)
            end
            -- exit function
            return
        end
    end
    -- no waveform filter found
    if opts.disable_hwdec then
        -- check for hardware decoding and disable it
        hwdec = mp.get_property("hwdec")
        if hwdec ~= "no" then
            mp.set_property("hwdec", "no")
            msg.info("Hardware decoding disabled")
            mp.osd_message("Hardware decoding disabled for the waveform filter", 2)
        end
    end
    -- create waveform video filter
    mp.command("no-osd vf add @waveform:lavfi=[" .. buildGraph() .. "]")
    msg.info("Created a waveform video filter")
end

function cycleFmt()
    opts.pixel_fmt = opts.fmts_available[fa_ri[opts.pixel_fmt]%#opts.fmts_available + 1]
    mp.osd_message("waveform: pixel format set to "..opts.pixel_fmt)
    rebuildGraph()
end

function rebuildGraph()
    -- iterate video filters and look for the waveform
    local video_filters = mp.get_property_native("vf")
    for index, filter in pairs(video_filters) do
        if filter["label"] == "waveform" then
            video_filters[index].params.graph = buildGraph()
            mp.set_property_native("vf", video_filters)
            msg.info("Rebuild waveform graph")
            return
        end
    end
end

function togglePos()
    --a bit of spagetti code, but I'm not a lua pro. Ist works :)
    if opts.defaultWavePos == "down" then
        opts.defaultWavePos = "up"
        mp.osd_message("Moved waveform to the TOP", 2)
    else
        opts.defaultWavePos = "down"
        mp.osd_message("Moved waveform to the BOTTOM", 2)
    end    
    rebuildGraph()
end

function init()
    for k,v in pairs(opts.fmts_available) do
        fa_ri[v]=k
    end
end

init()

mp.add_key_binding("c", "toggle-waveform", toggleFilter)
mp.add_key_binding("C", "cycle-waveform-type", cycleFmt)
mp.add_key_binding("Alt+c", "toggle-waveform-position", togglePos)
