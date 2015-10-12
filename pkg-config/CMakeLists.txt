INCLUDE (PkgConfigCommon)

SET (PkgConfigLibs "")
IF (WIN32)
  SET (PkgConfigLibs "${PkgConfigLibs} -l${PROJECT_LOWERCASE_NAME}-iface-${MAJOR}")
  SET (PkgConfigLibs "${PkgConfigLibs} -l${PROJECT_LOWERCASE_NAME}-host-iface-${MAJOR}")
  SET (PkgConfigLibs "${PkgConfigLibs} -l${PROJECT_LOWERCASE_NAME}-loader-${MAJOR}")
ELSE (WIN32)
  SET (PkgConfigLibs "${PkgConfigLibs} -l${PROJECT_LOWERCASE_NAME}-iface.so.${MAJOR}")
  SET (PkgConfigLibs "${PkgConfigLibs} -l${PROJECT_LOWERCASE_NAME}-host-iface.so.${MAJOR}")
  SET (PkgConfigLibs "${PkgConfigLibs} -l${PROJECT_LOWERCASE_NAME}-loader.so.${MAJOR}")
ENDIF (WIN32)

CONFIGURE_FILE (
  "${CMAKE_CURRENT_SOURCE_DIR}/pkg-config.pc.in"
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_LOWERCASE_NAME}-${MAJOR}.pc"
)
