shim.so: shim.c
	gcc -s -O3 -shared -g -fPIC -o shim.so shim.c -ldl 

LOCALPATH := $(shell pwd)

LTRACE := 
#LTRACE := ltrace -e fopen@* -e open@* -e stat@* -e fstat@* -e openat@* -e mkdir@*
#LTRACE := latrace -s fopen,stat,open
#LTRACE := ltrace -e getenv@*

# -e fopen@* -e open@* -e fstat@* -e *@MAIN -e -sinf@MAIN -e -cosf@MAIN
#${HOME}/.steam/bin64/gameoverlayrenderer.so

run: shim.so
	{\
		cd "/home/${USER}/.local/share/Steam/steamapps/common/Divinity Original Sin Enhanced Edition"; \
		allow_glsl_extension_directive_midshader=true LD_PRELOAD="${LOCALPATH}/shim.so:${HOME}/.steam/bin64/gameoverlayrenderer.so" \
			MESA_GLSL_VERSION_OVERRIDE=420 MESA_GL_VERSION_OVERRIDE=4.2 \
			LD_LIBRARY_PATH="." ${LTRACE} ./EoCApp; \
	}