module Advantage
  pkg_version = ''
  File.open(File.join('ext', 'advantage', 'advantage.c') ) do |f|
    f.grep( /const char\* VERSION/ ) do |line|
      pkg_version = /\s*const char\* VERSION\s*=\s*["|']([^"']*)["|'];\s*/.match(line)[1]
    end
  end
  VERSION = pkg_version
end
