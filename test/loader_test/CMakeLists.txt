SET (BinName loader_test)
FILE (GLOB_RECURSE BinSources RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} LoaderTest.vala)
SET (BinPackages gee-0.8 gio-2.0)
SET (BinCustomVapis ${CMAKE_BINARY_DIR}/src/loader/${PROJECT_LOWERCASE_NAME}-loader-${MAJOR}.vapi
     ${CMAKE_BINARY_DIR}/src/plugin-iface/${PROJECT_LOWERCASE_NAME}-iface-${MAJOR}.vapi
     ${CMAKE_BINARY_DIR}/test/loader_test-iface/loader_test-iface-${MAJOR}.vapi
     ${CMAKE_BINARY_DIR}/src/host-iface/${PROJECT_LOWERCASE_NAME}-host-iface-${MAJOR}.vapi
)
SET (BinLinkLibs ${PROJECT_LOWERCASE_NAME}-loader
                 ${PROJECT_LOWERCASE_NAME}-iface
                 ${PROJECT_LOWERCASE_NAME}-host-iface
                 loader_test-iface
)
INCLUDE_DIRECTORIES ("${CMAKE_BINARY_DIR}/src/loader"
                     "${CMAKE_BINARY_DIR}/src/plugin-iface"
                     "${CMAKE_BINARY_DIR}/test/loader_test-iface"
                     "${CMAKE_BINARY_DIR}/src/host-iface"
)
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
"List Plugins:
  Name = TypeA1
  Name = TypeA2
  Name = TypeB1
  Name = TypeB2
Creating PluginTypeA Object:
  TypeA1 init \\\\(\\\\) called
Call a.method_a \\\\(\\\\) from main app:
  TypeA1.method_a \\\\(\\\\) called
Call IHostLoaderTest.method_host \\\\(\\\\) from TypeA1:
  LoaderTestHost.method_host \\\\(\\\\) called
Destroing PluginTypeA Object:
  TypeA1 deinit \\\\(\\\\) called
Creating PluginTypeB Object:
  TypeB1 init \\\\(\\\\) called
Call b.method_b \\\\(\\\\) from main app:
  TypeB1.method_b \\\\(\\\\) called
  Returned String: TypeB1 returned string
Destroing PluginTypeB Object:
  TypeB1 deinit \\\\(\\\\) called"
)
SET_TESTS_PROPERTIES(loader_test-SimpleLoaderTest PROPERTIES ENVIRONMENT "LANG=en")

# enable testing
ENABLE_TESTING ()
