Name
	device drivers - The Advance device drivers

	This file describes the video, sound, joystick, mouse and keyboard
	drivers used by the Advance programs.

Video Drivers
  Types of Drivers
	The video drivers can be divided in two different categories:

	* Generate drivers able to program directly the video board.
	* System drivers able to use only the available video modes.

    Generate drivers
	This set of drivers is able to program the directly the video board
	to always generate a perfect video mode with the correct size
	and frequency.

	They always work in `fullscreen' output mode and generally support 
	only a subset of video boards.

	To function correctly these drivers require a correct configuration
	of the device_video_* options.

	The `Generate' drivers are always the preferred choice.

    System drivers
	This set of drivers is able to use only the video modes available
	on the operating system.

	They can work in `fullscreen' mode, `window' mode and `zoom' output mode
	using the video board hardware acceleration to stretch the image.
	The default output mode is `window' if you run the program in a window
	manager, otherwise the output mode `fullscreen' is chosen.

	Please note that these drivers generally need to stretch the image
	losing a lot in image quality and speed.

  Available Drivers
	The following is the list of all the video drivers supported.

    svgaline - Generate DOS SVGA modes
	This driver works in DOS and is able to use video modes obtained
	tweaking the hardware registers of the recognized SVGA boards.

	All clocks, all bit depths are available.
	To use these modes your video board must be supported
	by a `svgaline' driver listed in the `carddos.txt' file.

	This driver is completely independent of the VBE BIOS
	of your board.

    vbeline - Generate DOS VBE (VESA) modes
	This driver works in DOS and is able to use video modes obtained
	tweaking the standard VBE BIOS mode changing the hardware registers
	of the SVGA.

	All clocks, all bit depths are available.

	To use these modes your video board must be supported
	by a `vbeline' driver listed in the `carddos.txt' file.

	These drivers work setting a video mode using the
	default VBE2 services and tweak some hardware SVGA
	registers to modify the obtained video mode.
	The driver `vbe3' is an exception. It requires the
	presence of a VBE3 BIOS to change the frequency of the
	desired video mode. Unfortunately the standard
	VBE3 services don't support a resolution size change.

	The resolution is changed modifying only the standard
	VGA registers. This hack may or not may works.
	Also the interlaced modes are only rarely supported
	by the various VBE3 BIOS because they are very rarely
	used in the standard PC monitors.

	If your video board isn't supported by any drivers and
	you don't have a VBE3 BIOS you can try installing a
	software VESA BIOS like the SciTech Display Doctor.

    vgaline - Generate DOS VGA modes
	This driver works in DOS and is able to use video modes obtained
	tweaking the hardware registers of the standard VGA.
	Usually these modes are called Tweaked, XMode, ZMode.

	Only the standard VGA pixel clocks 6.29, 7.08, 12.59,
	14.16 MHz are available. Only 8 bit color modes. Only
	256 kBytes of video memory.

	This driver supports also text modes with pixel clocks
	12.59, 14.16, 25.17, 28.32 MHz.

	This driver is completely independent of the VGA BIOS
	of your board.

    vbe - System DOS VBE modes
	This driver works in DOS and is able to use video modes reported
	by the VBE BIOS.

	It doesn't require any `device_video_*' options because it cannot
	control how the video modes are generated.
    
    svgalib - Generate Linux SVGA modes
	This driver works in Linux and is able to use video modes obtained
	tweaking the hardware registers of the recognized SVGA boards using
	the SVGALIB library.

	All clocks, all bit depths are available.
	To use these modes your video board must be supported
	by a `svgalib' driver listed in the `cardlinx.txt' file.

	To use this driver you need to install the SVGALIB library
	version 1.9.x.

    fb - Generate Linux Frame Buffer modes
	This driver works in Linux and is able to use video modes
	from the Linux Kernel Console Frame Buffer.

	To use this driver you must activate the Console Frame Buffer
	support in your Linux kernel.

    sdl - System SDL modes
	This driver works in Linux, Windows and Mac OS X and is able to
	use video modes reported by the SDL graphics library.

    slang - System Linux sLang text modes
	This driver works in Linux and is able to use current terminal text
	mode from the Linux sLang library.

    svgawin - Generate Windows SVGA modes
	This driver works in Windows NT/2000/XP and is able to use video
	modes obtained tweaking the hardware registers of the recognized
	SVGA boards.

	All clocks, all bit depths are available.

	To use these modes your video board must be supported
	by a `svgawin' driver listed in the `cardwin.txt' file.

	To use this driver you need to install the included SVGAWIN
	driver. Please read the `svgawin.txt' file carefully.

Video Drivers Configuration
	The following are the video configuration options available for
	all the programs.

  Common Configuration Options
    device_video
	Selects the video driver to use.

	:device_video auto | (DEVICE[/MODEL])+

	Options:
		auto - Automatic detection of all the available drivers
			(default).

	The order of detection:
		DOS - svgaline, vbeline, vgaline, vbe.
		Linux - svgalib, fb, sdl, slang.
		Mac OS X - sdl.
		Windows - svgawin, sdl.

	Options for Linux:
		svgalib - SVGA generated graphics modes with the
			SVGALIB 1.9.x library. This driver is not
			available in X (when the environment DISPLAY
			variable is defined).
		fb - SVGA generated graphics modes with the Linux Console
			Frame Buffer. This driver is not
			available in X (when the environment DISPLAY
			variable is defined).
		slang - Text video modes with the sLang library.
		sdl - SDL graphics and fake text modes.

	Options for Mac OS X:
		sdl - SDL graphics and fake text modes.

	Options for DOS:
		svgaline - SVGA generated graphics modes.
		vbeline - VBE generated graphics modes.
		vgaline - VGA generated text and graphics modes.
		vbe - VBE graphics modes.

	Options for Windows:
		svgawin - SVGA generated graphics modes with the
			SVGAWIN included library. To use this driver you
			need to install the `svgawin.sys' driver with the
			`svgawin.exe' command line utility.
		sdl - SDL graphics and fake text modes.

	Please note that to use the utilities `advv' and `advcfg' you
	must at least select a graphics and a text video driver. The
	available text video drivers are `vgaline' for DOS, `slang' and 
	`sdl' for Linux and `sdl' for Windows.

	You can force the detection of a specific model of video board
	adding the name of the model driver after the driver name using
	the `/' separator. For example to force the `vbe3' model
	detection of the `vbeline' driver you must specify
	`vbeline/vbe3'. A complete list of all the available model is in
	the `card*.txt' files. 
	
	Please note that forcing a specific video driver is discouraged.
	Generally you don't need it.

	For a more complete description of the drivers check the
	previous `VIDEO DRIVER' section.

	Example to enable the `vbeline' and the `vgaline' drivers
	with auto-detection for DOS :
		:device_video vbeline vgaline

	Example to force the `vbeline/vbe3' driver and the `vgaline'
	driver for DOS :
		:device_video vbeline/vbe3 vgaline

	Example to enable the `fb' and `slang' driver for Linux :
		:device_video fb slang

    device_video_output
	Select the output mode.

	:device_video_output auto | window | fullscreen | zoom

	Options:
		auto - Automatically chosen (default).
		window - Use a window display.
		fullscreen - Use a fullscreen display.
		zoom - Zoom the image to fullscreen using the
			video board hardware. This mode uses a
			YUV overlay available only in some environments,
			like xv in X Window and DirectX in Windows.
			The specific format used is YUY2.

	Please note that with the zoom mode, if the original image is in the
	RGB format instead of a palette format, the program
	needs to convert it to the YUY2 format before displaying it.
	It requires some time.

    device_video_zoom
	Select the favorite horizontal size to use with the `zoom' output
	mode. The program selects the nearest available video mode.

	device_video_zoom SIZE

	Options:
		SIZE - The favorite horizontal size (default 1024).

	This option has effect only with the `zoom' output mode.

    device_video_cursor
	Select the mouse cursor mode.

	:device_video_cursor auto | off | on

	Options:
		auto - Automatically choose (default). The cursor
			is enabled in window modes, and disabled
			in fullscreen modes.
		off - Always off.
		on - Always on, only if the video mode support it.

  Generate Configuration Options
	The following are the common video configuration options
	available for all `generate' video drivers, i.e. all the
	video drivers with the exception of `sdl' and `vbe'.
	The `sdl' and `vbe' video drivers simply ignore all these
	options.

    device_video_pclock/hclock/vclock
	Specify the monitor frequency range in term of horizontal and
	vertical clocks. This option is MANDATORY.
	Generally these values are specified in the technical page of 
	your monitor manual. 

	:device_video_pclock P_LOW - P_HIGH
	:device_video_hclock H_LOW - H_HIGH [, H_LOW - H_HIGH] [, H_FIXED]
	:device_video_vclock V_LOW - V_HIGH [, V_LOW - V_HIGH] [, V_FIXED]

	If you are using the svgalib driver in Linux you need also to
	adjust the SVGALIB configuration file /etc/vga/libvga.config
	and correctly set the HorizSync and VertRefresh options.
	You must use a range equal or larger ranges than specified with
	the hclock and vclock options.

	Options:
		P_LOW - P_HIGH - Pixel clock range in MHz
			The lower value is the lower clock generable
			by your video board. The higher value is the
			video bandwidth of your monitor. If don't know
			these values you can start with `pclock 5 - 90'
			which essentially enable any video mode.
		H_LOW - H_HIGH - Horizontal clock range in kHz
		H_FIXED - Horizontal fixed clock in kHz
		V_LOW - V_HIGH - Vertical clock range in Hz
		V_FIXED - Vertical fixed clock in Hz

	Example for a Generic PC SVGA multisync monitor :
		:device_video_pclock 10 - 150
		:device_video_hclock 30.5 - 60
		:device_video_vclock 55 - 130

	Example for a Generic PC VGA monitor :
		:device_video_pclock 10 - 50
		:device_video_hclock 31.5
		:device_video_vclock 55 - 130

	Example for a PAL/SECAM TV (European) :
		:device_video_pclock 5 - 50
		:device_video_hclock 15.62
		:device_video_vclock 50

	Example for a PAL/SECAM TV (European) which supports also NTSC
	modes (very common if you use the SCART input) :
		:device_video_pclock 5 - 50
		:device_video_hclock 15.62, 15.73
		:device_video_vclock 50, 60

	Example for a NTSC TV (USA) :
		:device_video_pclock 5 - 50
		:device_video_hclock 15.73
		:device_video_vclock 59.94

	Example for a Generic Arcade Monitor Standard Resolution 15 kHz (CGA) :
		:device_video_pclock 5 - 50
		:device_video_hclock 15.75
		:device_video_vclock 50 - 60

	Example for a Generic Arcade Monitor Medium Resolution 25 kHz (EGA) :
		:device_video_pclock 5 - 50
		:device_video_hclock 25
		:device_video_vclock 50 - 60

	Example for a Generic Atari Monitor Extended Resolution 16 kHz
		:device_video_pclock 5 - 50
		:device_video_hclock 16.5
		:device_video_vclock 53

	Please note that the manuals of some Arcade Monitors incorrectly
	state to support a wide range of horizontal frequency
	like 15 - 31 kHz. Generally these monitors support only the
	three fixed frequency 15.75, 25, 31.1 kHz. For example the
	Wells Gardner D9200.

    device_video_modeline
	Define a video modeline. The modeline format is compatible with
	the format used by the Linux SVGALIB library and by the
	XFree Window system.

	:device_video_modeline Name CLOCK HDE HRS HRE HT VDE VRS VRE VT [-hsync] [-vsync] [+hsync] [+vsync] [doublescan] [interlace] [tvpal] [tvntsc]

	Options:
		Name - Name of the video mode. You can use the quotes
			'"` for the names with spaces.
		CLOCK - Pixel clock in MHz
		HDE HRS HRE HT - Horizontal `Display End',
			`Retrace Start', `Retrace End', `Total'
		VDE VRS VRE VT - Vertical `Display End',
			`Retrace Start', `Retrace End', `Total'
		-hsync -vsync +hsync +vsync - Polarization mode.
		doublescan - Doublescan mode.
		interlace - Interlaced mode.
		tvpal - Modeline converted to PAL format by the internal
			video board scan converter.
		tvntsc - Modeline converted to NTSC format by the internal
			video board scan converter.

	Example:
		:device_video_modeline tweak320x240 12.59 320 336 356 400 240 249 254 262 doublescan -hsync -vsync

	The `tvpal' and `tvntsc' are available only for the nVidia
	svgaline driver.

    device_video_format
	Select the format of the video modes to create.
	You can insert more than one of these option.
	
	:device_video_format HCLOCK HDE HRS HRE HT VDE VRS VRE VT

	Options:
		HCLOCK - Horizontal clock in Hz
		HDE HRS HRE HT VDE VRS VRE VT - Like the modeline option

	When a new modeline is created, AdvanceMAME uses a linear
	interpolation of the two formats with the nearest horizontal
	clock.

	The default value of this option is for an Arcade 15 kHz monitor :

		:15720 0.737 0.075 0.074 0.113 0.916 0.012 0.012 0.060

	and for an Arcade 25 kHz monitor:

		:25000 0.800 0.020 0.100 0.080 0.922 0.006 0.012 0.060

	and for a VGA 31.5 kHz monitor:

		:31500 0.800 0.020 0.120 0.060 0.914 0.019 0.004 0.063

	Which one of these defaults is used depends on the setting of the 
	device_video_hclock option.

    device_video_singlescan/doublescan/interlace
	Limit the use of certain features.

	:device_video_singlescan yes | no
	:device_video_doublescan yes | no
	:device_video_interlace yes | no

	Options:
		yes - Permits the use of the feature if the
			low end driver allow it (default).
		no - Disable completely the feature.

    device_color_palette8/br8/bgr15/bgr16/bgr24/bgr32/yuy2
	Limit the use of some bit depths. If you known that
	the program doesn't work well with a specific bit depth you
	can disable it.

	:device_color_palette8 yes | no
	:device_color_bgr8 yes | no
	:device_color_bgr15 yes | no
	:device_color_bgr16 yes | no
	:device_color_bgr24 yes | no
	:device_color_bgr32 yes | no
	:device_color_yuy2 yes | no

	Modes:
		palette8 - Palettized 8 bits mode.
		bgr8 - RGB 8 bits mode.
		bgr15 - RGB 15 bits mode.
		bgr16 - RGB 16 bits mode.
		bgr24 - RGB 24 bits mode.
		bgr32 - RGB 32 bits mode.
		yuy2 - YUV mode in the YUY2 format.

	Options:
		yes - Permits the use of the bit depth if the
			low end driver allow it (default).
		no - Disable completely the bit depth.

    device_video_fastchange
	Enable or disable the fast video mode change. If enabled the
	current video mode is not reset before setting another video
	mode. The reset isn't generally required, but some
	limited DOS video BIOS need it. So, the fast change is disabled 
	for default.

	:device_video_fastchange yes | no

	Options:
		yes - Enable the fast video mode change.
		no - Disable the fast video mode change (default).

  VBELine Configuration Options
	The following are the common video configuration options
	available only for the `vbeline' DOS video driver.

    device_vbeline_mode
	Select which `vbe' mode to use when generating `vbeline' modes.

	The use of this option is discouraged, it's present only for testing.

	:device_vbeline_mode smaller | bigger | ...

	Options:
		smaller - Use the biggest `vbe' mode contained in
			the `vbeline' mode (default).
		bigger - Use the smallest `vbe' mode which contains
			the `vbeline' mode.
		smaller_upto640 - Like `smaller' but not
			bigger than 640x480.
		bigger_upto640 - Like `bigger' but not
			bigger than 640x480.
		320 - Use always the 320x240 mode.
		400 - Use always the 400x300 mode.
		512 - Use always the 512x384 mode.
		640 - Use always the 640x480 mode.
		800 - Use always the 800x600 mode.

  SVGALine Configuration Options
	The following are the common video configuration options
	available only for the `svgaline' DOS video driver.

    device_svgaline_divideclock
	Divide the pixelclock using the VGA sequencer. It should help to support 
	lower pixel clocks on some boards.

	The use of this option is discouraged, it's present only for testing.

	:device_svgaline_divideclock yes | no

	Options:
		yes - Divide the clock by 2.
		no - Don't divide the clock (default).
 
  SVGAWin Configuration Options
	The following are the common video configuration options
	available only for the `svgawin' Windows video driver.

    device_svgawin_stub
	Select how the driver uses the Windows graphics.

	The use of this option is discouraged, it's present only for testing.

	Options:
		none - Don't use the Windows graphics support.
		window - Create a stub window before setting the video mode.
		fullscreen - Create a stub fullscreen window before setting
			the video mode (default).

    device_svgawin_divideclock
	Divide the pixelclock using the VGA sequencer. It should help to support 
	lower pixel clocks on some boards.

	The use of this option is discouraged, it's present only for testing.

	:device_svgawin_divideclock yes | no

	Options:
		yes - Divide the clock by 2.
		no - Don't divide the clock (default).

Sound Drivers
  Available Drivers
	The following is the list of all the sound drivers supported.

    alsa - Linux ALSA sound
	This driver works in Linux and it use the ALSA sound library.

    oss - Linux OSS sound
	This driver works in Linux and it use the OSS sound library.

    seal - DOS SEAL sound
	This driver works in DOS and it use the SEAL sound library with
	some specific changes for MAME.

    allegro - DOS Allegro sound
	This driver works in DOS and it use the Allegro library.

    vsync - DOS VSYNC sound
	This driver works in DOS and it use the VSync sound drivers
	from the VSyncMAME emulator.

	More info is in the VSyncMAME page :

		http://vsyncmame.mameworld.net

    sdl - SDL sound
	This driver works in Linux, Windows and Mac OS X and it use
	the SDL library.

	It isn't able to use the hardware volume control of the sound card.
	The volume changes are simulated reducing the sample value.

	It isn't able precisely control the amount of bufferized samples.
	This means that it may add a small latency on the sound output.

Sound Drivers Configuration
    device_sound
	Specify the sound-card.

	:device_sound auto | none | DEVICE

	Options:
		none - No sound.
		auto - Automatic detection (default).

	Options for Linux:
		alsa - ALSA automatic detection.
		oss - OSS automatic detection.
		sdl - SDL automatic detection.

	Options for Mac OS X:
		sdl - SDL automatic detection.

	Options for DOS:
		seal - SEAL automatic detection.
		seal/sb - Sound Blaster.
		seal/pas - Pro Audio Spectrum.
		seal/gusmax - Gravis Ultrasound Max.
		seal/gus - Gravis Ultrasound.
		seal/wss - Windows Sound System.
		seal/ess - Ensoniq Soundscape.
		allegro - Allegro automatic detection.
		allegro/sb10 - Sound Blaster 1.0.
		allegro/sb15 - Sound Blaster 1.5.
		allegro/sb20 - Sound Blaster 2.0.
		allegro/sbpro - Sound Blaster Pro.
		allegro/sb16 - Sound Blaster 16.
		allegro/audio - Ensoniq AudioDrive.
		allegro/wss - Windows Sound System.
		allegro/ess - Ensoniq Soundscape.
		vsync/sb -  Sound Blaster.
		vsync/sbwin - Sound Blaster (Windows).
		vsync/ac97 - AC97.
		vsync/ac97win - AC97 (Windows).
		vsync/gusmax - Gravis Ultrasound Max.
		vsync/gus - Gravis Ultrasound.
		vsync/audio - Ensoniq AudioDrive.
		vsync/wss - Windows Sound System.
		vsync/ess- Ensoniq Soundscape.

	Options Windows:
		sdl - SDL automatic detection.

Input Drivers Configuration
    device_keyboard
	Selects the keyboard drivers.

	:device_keyboard auto | none

	Options:
		none - No keyboard.
		auto - Automatic detection (default).

	Options for Linux:
		svgalib - SVGALIB keyboard. This driver is not available
			if the SDL video output is used.
		raw - Linux RAW kernel keyboard interface. This driver
			is not available if the SDL video output is used.
		sdl - SDL keyboard. This driver is available
			only if the SDL video output is used.

	Options for Mac OS X:
		sdl - SDL keyboard.

	Options for DOS:
		allegro - Allegro automatic detection.

	Options for Windows:
		sdl - SDL automatic detection.

    device_joystick
	Selects the joystick driver.

	:device_joystick auto | none | DEVICE

	Options:
		none - No joystick (default).
		auto - Automatic detection.

	Options for Linux:
		svgalib - SVGALIB automatic detection.
		sdl - SDL automatic detection.

	If you use the `svgalib' driver remember to configure the
	correct joystick in the SVGALIB configuration file.

	Options for Mac OS X:
		sdl - SDL automatic detection.

	Options for DOS:
		allegro - Allegro automatic detection.
		allegro/standard - Standard joystick.
		allegro/dual - Dual joysticks.
		allegro/4button - 4-button joystick.
		allegro/6button - 6-button joystick.
		allegro/8button - 8-button joystick.
		allegro/fspro - CH Flightstick Pro.
		allegro/wingex - Logitech Wingman Extreme.
		allegro/sidewinder - Sidewinder.
		allegro/sidewinderag - Sidewinder Aggressive.
		allegro/gamepadpro - GamePad Pro.
		allegro/grip - GrIP.
		allegro/grip4 - GrIP 4-way.
		allegro/sneslpt1 - SNESpad LPT1.
		allegro/sneslpt2 - SNESpad LPT2.
		allegro/sneslpt3 - SNESpad LPT3.
		allegro/psxlpt1 - PSXpad LPT1.
		allegro/psxlpt2 - PSXpad LPT2.
		allegro/psxlpt3 - PSXpad LPT3.
		allegro/n64lpt1 - N64pad LPT1.
		allegro/n64lpt2 - N64pad LPT2.
		allegro/n64lpt3 - N64pad LPT3.
		allegro/db9lpt1 - DB9 LPT1.
		allegro/db9lpt2 - DB9 LPT2.
		allegro/db9lpt3 - DB9 LPT3.
		allegro/tgxlpt1 - TGX-LPT1.
		allegro/tgxlpt2 - TGX LPT2.
		allegro/tgxlpt3 - TGX LPT3.
		allegro/segaisa - IF-SEGA/ISA.
		allegro/segapci - IF-SEGA2/PCI.
		allegro/segapcifast - IF-SEGA2/PCI (normal).
		allegro/wingwarrior - Wingman Warrior.

	Options for Windows:
		sdl - SDL automatic detection.

    device_mouse
	Selects the mouse driver.

	:device_mouse auto | none

	Options:
		none - No mouse (default).
		auto - Automatic detection.

	Options for Linux:
		svgalib - SVGALIB automatic detection.
		sdl - SDL automatic detection.

	If you use the `svgalib' driver remember to configure the
	correct mouse in the SVGALIB configuration file.

	Options for Mac OS X:
		sdl - SDL automatic detection.

	Options for DOS:
		allegro - Allegro automatic detection.

	The Allegro driver also uses the special `optimous' driver
	for a second mouse. The `optimous' driver is available in
	the `contrib/' directory.

	Options for Windows:
		sdl - SDL automatic detection.

Copyright
	This file is Copyright (C) 2003 Andrea Mazzoleni.

