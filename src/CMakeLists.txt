cmake_minimum_required(VERSION 3.1)

project(ACTv3PortablePatch C CXX)

if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
   message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
   file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/v0.11/conan.cmake"
                 "${CMAKE_BINARY_DIR}/conan.cmake")
endif()

include(${CMAKE_BINARY_DIR}/conan.cmake)


IF(MSVC)
  OPTION(USE_STATIC_RUNTIME_LIBRARY "Use Static Runtime Library" ON)
  OPTION(USE_LINK_TIME_OPTIMIZATION "Use Link Time Optimization" ON)

  foreach (flag_var
           CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
           CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO
           CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
           CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO)

    set(_PARAM "")
    IF(USE_STATIC_RUNTIME_LIBRARY)
      string(FIND "${${flag_var}}" "/MT" _TESTVAR)
      if(${_TESTVAR} EQUAL "-1")
        string(FIND "${${flag_var}}" "/MD" _TESTVAR)
        if(${_TESTVAR} EQUAL "-1")
          set(_PARAM "${_PARAM} /MT ")
        else()
          string(REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
        ENDIF()
      ENDIF()
    ENDIF()
    IF(USE_LINK_TIME_OPTIMIZATION)
      set(_PARAM "${_PARAM} /GL ")
    ENDIF()
    
    # multi processor
    string(FIND "${${flag_var}}" "/MP" _TESTVAR)
    if(${_TESTVAR} EQUAL "-1")
      set(_PARAM "${_PARAM} /MP")
    endif()
    if(_PARAM)
      set(${flag_var} "${${flag_var}} ${_PARAM}" CACHE STRING "" FORCE)
    ENDIF()
    
  endforeach()

  IF(USE_LINK_TIME_OPTIMIZATION)
      message(STATUS "- MSVC: Enabled multiprocess build option")
      foreach (flag_var
               CMAKE_EXE_LINKER_FLAGS CMAKE_EXE_LINKER_FLAGS_DEBUG CMAKE_EXE_LINKER_FLAGS_RELEASE
               CMAKE_EXE_LINKER_FLAGS_MINSIZEREL CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO
               CMAKE_SHARED_LINKER_FLAGS CMAKE_SHARED_LINKER_FLAGS_DEBUG CMAKE_SHARED_LINKER_FLAGS_RELEASE
               CMAKE_SHARED_LINKER_FLAGS_MINSIZEREL CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO
               CMAKE_MODULE_LINKER_FLAGS CMAKE_MODULE_LINKER_FLAGS_DEBUG CMAKE_MODULE_LINKER_FLAGS_RELEASE
               CMAKE_MODULE_LINKER_FLAGS_MINSIZEREL CMAKE_MODULE_LINKER_FLAGS_RELWITHDEBINFO)
        string(FIND "${${flag_var}}" "/LTCG" _TESTVAR)
        if(${_TESTVAR} EQUAL "-1")
          set(${flag_var} "${${flag_var}} /LTCG" CACHE STRING "" FORCE)
        endif()
      endforeach()
      foreach (flag_var
               CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
               CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO
               CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
               CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO)
        string(REPLACE "${${flag_var}}" "${${flag_var}} /GL" ${flag_var} "${${flag_var}}")
      endforeach()
  ENDIF(USE_LINK_TIME_OPTIMIZATION)
ENDIF()

if(CMAKE_SIZEOF_VOID_P EQUAL 4)
  configure_file(conanfile.py "${CMAKE_CURRENT_SOURCE_DIR}/_conanfile86.py" @ONLY)
  conan_cmake_run(CONANFILE "_conanfile86.py"
                BASIC_SETUP
                SETTINGS arch=x86
                BUILD missing)
elseif(CMAKE_SIZEOF_VOID_P EQUAL 8)
  configure_file(conanfile.py "${CMAKE_CURRENT_SOURCE_DIR}/_conanfile64.py" @ONLY)
  conan_cmake_run(CONANFILE "_conanfile64.py"
                BASIC_SETUP
                SETTINGS arch=x86_64
                BUILD missing)
endif()

ADD_DEFINITIONS(
  ${CONAN_DEFINES_BOOST}
  -DUNICODE
  -D_UNICODE
)

ADD_EXECUTABLE(ActPortablePatch
  version.h
  version.cpp
  main.cpp
  resource.h
  Resource.rc
  Setting.il
  util.h
  util.cpp
  System.EnvironmentMod.GetFolderPath.il
)

conan_target_link_libraries(ActPortablePatch)
