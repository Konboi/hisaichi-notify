require 'uuidtools'
require 'msgpack'

class Message
  include ActiveModel::Model

  attr_accessor :time, :text, :key

  validates_presence_of :time
  validates_numericality_of :time, :greater_than => 0
  validates_presence_of :text

  def self.new_from_key_and_msgpack(key, msgpack)
    hash = MessagePack.unpack(msgpack)
    hash["time"] -= Time.now.to_i
    hash["key"]   = key
    self.new hash
  end

  def key
    @key ||= UUIDTools::UUID.random_create.to_s
  end
end
