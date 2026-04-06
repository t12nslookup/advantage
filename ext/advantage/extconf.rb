#====================================================
#
#    Copyright 2008-2010 iAnywhere Solutions, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#                                                                               
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
#====================================================

require 'mkmf'

CONFIG["debugflags"] = "-ggdb3"
CONFIG["optflags"] = "-O0"

if RUBY_PLATFORM =~ /x64/
  $defs << "-Dx64"
elsif RUBY_PLATFORM =~ /mingw|mswin/
  # On 32-bit MinGW, ADS_WIN32 is defined but ENTRYPOINT falls through to
  # _declspec(dllexport) which MinGW doesn't support (needs __declspec).
  # Defining ADS_NT routes ENTRYPOINT to plain WINAPI instead.
  $defs << "-DADS_NT"
end

# GCC 14+ (used by newer MinGW) promotes -Wincompatible-pointer-types to an
# error by default. The rb_define_method calls use the old VALUE(*)(ANYARGS)
# pattern which triggers this — downgrade back to a warning.
$CFLAGS << " -Wno-incompatible-pointer-types"

dir_config('ADS')

create_makefile("advantage")

