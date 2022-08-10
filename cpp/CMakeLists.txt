include_directories(${CMAKE_CURRENT_LIST_DIR})

include(${CMAKE_CURRENT_LIST_DIR}/quick/toolkits/CMakeLists.txt)
set(
    CPP_SOURCES
    ${TOOLKIT_SOURCES}

    ${CMAKE_CURRENT_LIST_DIR}/appoptions.cpp
    ${CMAKE_CURRENT_LIST_DIR}/appoptions.h
    ${CMAKE_CURRENT_LIST_DIR}/checks.cpp
    ${CMAKE_CURRENT_LIST_DIR}/checks.h
    ${CMAKE_CURRENT_LIST_DIR}/main.cpp
    ${CMAKE_CURRENT_LIST_DIR}/systemcolors.cpp
    ${CMAKE_CURRENT_LIST_DIR}/systemcolors.h
    ${CMAKE_CURRENT_LIST_DIR}/trickstools.cpp
    ${CMAKE_CURRENT_LIST_DIR}/trickstools.h
)
