SET (PluginName type_b2)
FILE (GLOB_RECURSE PluginSources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} TypeB2.vala)
SET (PluginCustomVapis
    ${CMAKE_BINARY_DIR}/src/plugin-iface/${PROJECT_LOWERCASE_NAME}-iface-${MAJOR}.vapi
    ${CMAKE_BINARY_DIR}/test/loader_test-iface/loader_test-iface-${MAJOR}.vapi
    ${CMAKE_BINARY_DIR}/src/host-iface/${PROJECT_LOWERCASE_NAME}-host-iface-${MAJOR}.vapi
)
SET (PluginLinkLibs gobject-plugin-iface loader_test-iface)
INCLUDE_DIRECTORIES ("${CMAKE_BINARY_DIR}/src/plugin-iface"
                     "${CMAKE_BINARY_DIR}/test/loader_test-iface"
                     "${CMAKE_BINARY_DIR}/src/host-iface"
)
INCLUDE (ValaPluginCommonRules)

#INSTALL (TARGETS ${PluginName} DESTINATION lib/${PROJECT_LOWERCASE_NAME}-${MAJOR}/plugins/${PluginName})
