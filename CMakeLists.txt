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
)
find_library(
    REQUIRED

    QAsemanCore
    QAsemanQml
    QAsemanGui
    QAsemanNetwork
)
#find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui Qml Quick)


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
    QAsemanCore
    QAsemanQml
    QAsemanGui
    QAsemanNetwork
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
