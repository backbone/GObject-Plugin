SET (BinName loader_test)
FILE (GLOB_RECURSE BinSources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} LoaderTest.vala)
SET (BinPackages gee-0.8 gio-2.0)
SET (BinCustomVapis ${CMAKE_BINARY_DIR}/src/loader/${PROJECT_LOWERCASE_NAME}-loader-${MAJOR}.vapi
     ${CMAKE_BINARY_DIR}/src/plugin-iface/${PROJECT_LOWERCASE_NAME}-iface-${MAJOR}.vapi
     ${CMAKE_BINARY_DIR}/test/loader_test-iface/loader_test-iface-${MAJOR}.vapi
)
SET (BinLinkLibs ${PROJECT_LOWERCASE_NAME}-loader ${PROJECT_LOWERCASE_NAME}-iface loader_test-iface
)
INCLUDE_DIRECTORIES ("${CMAKE_BINARY_DIR}/src/loader" "${CMAKE_BINARY_DIR}/src/plugin-iface"
"${CMAKE_BINARY_DIR}/test/loader_test-iface")
INCLUDE (ValaBinCommonRules)

# Plugin Loading Test
MACRO (plugin_loading_test testname regexp)
  ADD_TEST (loader_test-${testname} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/loader_test)
  SET_TESTS_PROPERTIES (loader_test-${testname}
  PROPERTIES PASS_REGULAR_EXPRESSION ${regexp}
             FAIL_REGULAR_EXPRESSION "CRITICAL;WARNING")
ENDMACRO (plugin_loading_test)

# Testing Plugin:[de]init() and Library unload()
plugin_loading_test (SimpleLoaderTest
"Plugin Type Name = TypeA1
Plugin Type Name = TypeA2
Plugin Type Name = TypeB1
Plugin Type Name = TypeB2
TypeA1 init
TypeA1.method_a \\\\(\\\\) called
TypeA1 deinit
TypeB1 init
TypeB1.method_b \\\\(\\\\) called
TypeB1 returned string
TypeB1 deinit"
)
SET_TESTS_PROPERTIES(loader_test-SimpleLoaderTest PROPERTIES ENVIRONMENT "LANG=en")

# enable testing
ENABLE_TESTING ()
