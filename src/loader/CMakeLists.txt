SET (LibName ${PROJECT_LOWERCASE_NAME}-loader)
FILE (GLOB_RECURSE LibSources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} PluginLoader.vala)
SET (LibPackages gee-0.8 gmodule-2.0 gio-2.0)
SET (LibCustomVapis ${CMAKE_BINARY_DIR}/src/plugin-iface/${PROJECT_LOWERCASE_NAME}-iface-${MAJOR}.vapi
     ${CMAKE_BINARY_DIR}/src/host-iface/${PROJECT_LOWERCASE_NAME}-host-iface-${MAJOR}.vapi
)
SET (LibExtraSources ${PROJECT_SOURCE_DIR}/src/library_constructor.c)
SET (LibInstall ON)
SET (LibLinkLibs ${PROJECT_LOWERCASE_NAME}-iface ${PROJECT_LOWERCASE_NAME}-host-iface gmodule-2.0)
INCLUDE_DIRECTORIES ("${CMAKE_BINARY_DIR}/src/plugin-iface"
                     "${CMAKE_BINARY_DIR}/src/host-iface"
)
INCLUDE (ValaLibCommonRules)
