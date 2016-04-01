SET (LibName type_b1)
SET (LibIsPlugin ON)
SET (LibNoApi ON)
FILE (GLOB_RECURSE LibSources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} TypeB1.vala)
SET (LibCustomVapis
    ${CMAKE_BINARY_DIR}/src/iface/${PROJECT_LOWERCASE_NAME}-iface-${MAJOR}.vapi
    ${CMAKE_BINARY_DIR}/test/loader_test-iface/loader_test-iface-${MAJOR}.vapi
)
SET (LibLinkLibs gobject-plugin-iface loader_test-iface)
INCLUDE_DIRECTORIES ("${CMAKE_BINARY_DIR}/src/iface"
                     "${CMAKE_BINARY_DIR}/test/loader_test-iface"
)
INCLUDE (ValaLibCommonRules)
