# lib3mf package for pkgsrc: the same interface as the __init__.py of
# the PyPI lib3mf wheel.  lib3mf.dylib (or lib3mf.so) in this directory
# is a symbolic link to the shared library installed by wip/lib3mf.
import os
import platform

_system = platform.system().lower()
if _system == "darwin":
    lib_file = "lib3mf.dylib"
elif _system == "windows":
    lib_file = "lib3mf.dll"
else:
    lib_file = "lib3mf.so"

lib_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), lib_file)

from .Lib3MF import *  # noqa: E402,F401,F403
from . import Lib3MF as _Lib3MF  # noqa: E402


def get_library_path():
    return lib_path


def get_library_path_for_wrapper():
    # Lib3MF.Wrapper() appends the platform's shared library suffix.
    return os.path.splitext(lib_path)[0]


def get_wrapper():
    return _Lib3MF.Wrapper(get_library_path_for_wrapper())


# During interpreter shutdown Lib3MF.ErrorCodes can already be None when
# Base.__del__ releases objects; skip the error check then (the PyPI
# wheel does the same).
_original_checkError = _Lib3MF.Wrapper.checkError


def _checkError(self, instance, errorCode):
    if getattr(_Lib3MF, "ErrorCodes", None) is None:
        return None
    return _original_checkError(self, instance, errorCode)


_Lib3MF.Wrapper.checkError = _checkError
