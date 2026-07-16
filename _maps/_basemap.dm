//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.
//#define ABSOLUTE_MINIMUM //uncomment this to load a smaller centcom and smaller runtime station, only works together with LOWMEMORYMODE

#ifdef ABSOLUTE_MINIMUM
#define LOWMEMORYMODE
#endif

#ifndef ABSOLUTE_MINIMUM
#include "map_files\generic\CentCom.dmm"
#else
#include "map_files\generic\CentCom_minimal.dmm"
#endif

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\debug\multiz.dmm"
		#include "map_files\debug\runtimestation.dmm"
		#include "map_files\Deltastation\DeltaStation2.dmm"
	#endif
	#ifdef ALL_TEMPLATES
		#include "templates.dm"
	#endif
	// NOVA EDIT ADDITION START
	#ifdef NOVA_TEMPLATES
		#include "templates_nova.dm"
	#endif
	// NOVA EDIT ADDITION END
#endif
