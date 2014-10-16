SET (LibName loader_test-iface)
FILE (GLOB_RECURSE LibSources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} LoaderTestInterface.vala)
SET (LibCustomVapis ${CMAKE_BINARY_DIR}/src/plugin-iface/${PROJECT_LOWERCASE_NAME}-iface-${MAJOR}.vapi
                    ${CMAKE_BINARY_DIR}/src/host-iface/${PROJECT_LOWERCASE_NAME}-host-iface-${MAJOR}.vapi
)
SET (LibLinkLibs gobject-plugin-iface)
INCLUDE_DIRECTORIES ("${CMAKE_BINARY_DIR}/src/plugin-iface"
                     "${CMAKE_BINARY_DIR}/src/host-iface"
)
INCLUDE (ValaLibCommonRules)
