# This simulates loading the coulda gem, but without relying on
# vendor/gems

coulda_path = File.join(File.dirname(__FILE__), *%w(.. .. .. ..))
coulda_lib_path = File.join(coulda_path, "lib")

$LOAD_PATH.unshift(coulda_lib_path)
load File.join(coulda_path, 'rails', 'init.rb')
