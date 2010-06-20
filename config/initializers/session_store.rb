require 'memcache'

CACHE = MemCache.new(:namespace => "objectbox")
CACHE.servers = 'localhost:11211'

ActionController::Base.session_store = :mem_cache_store
ActionController::Base.session = {
  :key         => '_objectbox_session',
  :secret      => '9679b4e90ace755815810e2fc5ba19d5f99a57265a4517ff79cf73b37ec055731c9b2f856e1251301105f9360fe3119692e1d2d01032e75ea02735072ed7b308',
  :cache       => CACHE
}
