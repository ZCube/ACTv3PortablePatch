from conans import ConanFile, CMake
import os

class DependencyConan(ConanFile):
  settings = "os", "compiler", "build_type", "arch"
  requires = "boost/1.66.0@conan/stable"
  generators = "cmake"
  default_options = "boost:shared=False"
