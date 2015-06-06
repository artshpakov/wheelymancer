module CacheManager
  extend self

  def get key
    value = storage.get key
    value && value.to_f
  end

  def set key, value
    value if storage.set key, value
  end

  def fetch key, &block
    get(key) || (set(key, block.call) if block_given?)
  end

  delegate :flushdb, to: :storage


  protected

  def storage
    @storage ||= Redis.new
  end
end
