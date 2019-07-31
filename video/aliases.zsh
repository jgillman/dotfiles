if _has mpv; then
  alias caca='mpv --really-quiet --vo=tct'
  alias mpv-drc='mpv --af="acompressor=ratio=4,loudnorm"'
  alias mpv-nightmode='mpv --af="pan=stereo|FL=FC+0.30*FL+0.30*FLC+0.30*BL+0.30*SL+0.60*LFE|FR=FC+0.30*FR+0.30*FRC+0.30*BR+0.30*SR+0.60*LFE"'
  alias mpv-nightmode-loudnorm='mpv --af="pan=stereo|FL=FC+0.30*FL+0.30*FLC+0.30*BL+0.30*SL+0.60*LFE|FR=FC+0.30*FR+0.30*FRC+0.30*BR+0.30*SR+0.60*LFE,loudnorm"'
fi
