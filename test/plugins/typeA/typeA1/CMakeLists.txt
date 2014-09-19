SET (PluginName type_a1)
FILE (GLOB_RECURSE PluginSources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} TypeA1.vala)
SET (PluginCustomVapis
    ${CMAKE_BINARY_DIR}/src/plugin-iface/${PROJECT_LOWERCASE_NAME}-iface-${MAJOR}.vapi
    ${CMAKE_BINARY_DIR}/test/loader_test-iface/loader_test-iface-${MAJOR}.vapi
)
SET (PluginLinkLibs gobject-plugin-iface loader_test-iface)
INCLUDE_DIRECTORIES ("${CMAKE_BINARY_DIR}/src/plugin-iface")
INCLUDE_DIRECTORIES ("${CMAKE_BINARY_DIR}/test/loader_test-iface")
INCLUDE (ValaPluginCommonRules)

#INSTALL (TARGETS ${PluginName} DESTINATION lib/${PROJECT_LOWERCASE_NAME}-${MAJOR}/plugins/${PluginName})
