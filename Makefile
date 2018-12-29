shim.so:
	gcc -s -O3 -shared -fPIC -o shim.so -ldl shim.c

LOCALPATH := $(shell pwd)

run: shim.so
		cd "/home/${USER}/.local/share/Steam/steamapps/common/Divinity Original Sin Enhanced Edition"; \
		allow_glsl_extension_directive_midshader=true LD_PRELOAD="${LOCALPATH}/shim.so:${HOME}/.steam/bin64/gameoverlayrenderer.so" \
			MESA_GLSL_VERSION_OVERRIDE=420 MESA_GL_VERSION_OVERRIDE=4.2 \
			LD_LIBRARY_PATH="." ./EoCApp; \
	}