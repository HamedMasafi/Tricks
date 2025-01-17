cmake_minimum_required(VERSION 3.16)

set(PROJECT_VERSION_MAJOR 1)
set(PROJECT_VERSION_MINOR 0)
set(PROJECT_VERSION_PATCH 0)
set(PROJECT_BUNDLE_VERSION 5)
set(APP_UNIQUEID "f293006e-ffe3-4609-b130-76d9d56b8278")
set(APP_DOMAIN "io.aseman")

add_definitions(-DAPP_VERSION="${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")
add_definitions(-DAPP_BUNDLE_VERSION=${PROJECT_BUNDLE_VERSION})
add_definitions(-DAPP_UNIQUEID="${APP_UNIQUEID}")
add_definitions(-DAPP_DOMAIN="${APP_DOMAIN}")

project(tricks VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


# Set up AUTOMOC and some sensible defaults for runtime execution
# When using Qt 6.3, you can replace the code block below with
# qt_standard_project_setup()
#set(CMAKE_AUTOMOC ON)
include(GNUInstallDirs)

find_package (
    Qt5
    REQUIRED COMPONENTS
        Core
        Gui
        Qml
        Quick
        Widgets
        QuickControls2
        Multimedia

        QAsemanCore
        QAsemanQml
        QAsemanGui
        QAsemanNetwork
)


include(objective-c/CMakeLists.txt)
include(cpp/CMakeLists.txt)

add_executable(
    tricks
    ${CPP_SOURCES}
    qml/qml.qrc
)
#include(qml/CMakeLists.txt)
#qt_add_resources(tricks qml/qml.qrc)

target_link_libraries(
    tricks PRIVATE
    Qt5::Core
    Qt5::Gui
    Qt5::Quick
    Qt5::Qml
    Qt5::Widgets
    Qt5::QuickControls2
    Qt5::Multimedia
    Qt5::QAsemanCore
    Qt5::QAsemanQml
    Qt5::QAsemanGui
    Qt5::QAsemanNetwork
)


if(NOT APP_SECRET_ID_ISEMPTY)
    target_compile_definitions(tricks PRIVATE
        APP_SECRET_ID=""
    )
endif()

if(APP_SECRET_ID_ISEMPTY AND NOT APP_SECRET_ID_INCLUDE_ISEMPTY)
    target_compile_definitions(tricks PRIVATE
        APP_SECRET_ID_INCLUDE=""
    )
endif()

install(TARGETS tricks
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Consider using qt_generate_deploy_app_script() for app deployment if
# the project can use Qt 6.3. In that case rerun qmake2cmake with
# --min-qt-version=6.3.


if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(tricks)
endif()

 if (TRICKS_BUILD_DIR)
     file(WRITE ${TRICKS_BUILD_DIR}/version "${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}")
     message("-- Version in file ${TRICKS_BUILD_DIR}/version saved")
 endif()


# CPack
 set(CPACK_PACKAGE_NAME ${PROJECT_NAME}
     CACHE STRING "Tricks"
 )
 set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Tricks"
     CACHE STRING "Social media for developers"
 )
 set(CPACK_PACKAGE_VENDOR "Aseman")
 set(CPACK_VERBATIM_VARIABLES YES)
 set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CPACK_PACKAGE_NAME})
 SET(CPACK_OUTPUT_FILE_PREFIX "${CMAKE_SOURCE_DIR}/_packages")

 set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
 set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
 set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
 set(CPACK_PACKAGE_DESCRIPTION   "Social media for developers")
 set(CPACK_PACKAGE_CONTACT "info@aseman.io")
 set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Aseman")

 set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
 set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")

 if (TRICKS_BUILD_DIR)
     set(CPACK_PACKAGE_FILE_NAME "tricks")
 else()
     set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)
 endif()

 set(CPACK_COMPONENTS_GROUPING ONE_PER_GROUP)
  set(CPACK_DEB_COMPONENT_INSTALL YES)
 set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)

 include(CPack)
