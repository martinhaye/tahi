class EventStream

  attr_accessor :action, :record, :subscription_name

  def initialize(action, record, subscription_name)
    @action = action
    @record = record
    @subscription_name = subscription_name
  end

  def post
    Accessibility.new(record).users.each do |user|
      channel = EventStreamConnection.channel_name(User, user.id)
      payload = payload_for(user)
      guid = cached_key(user.id, payload)
      EventStreamConnection.notify(channel, guid)
    end
  end

  def destroy
    channel = EventStreamConnection::SYSTEM_CHANNEL_NAME
    guid = cached_key("public", destroyed_payload)
    EventStreamConnection.notify(channel, guid)
  end

  def destroy_for(user)
    if Accessibility.new(record).disconnected?(user)
      channel = EventStreamConnection.channel_name(User, user.id)
      guid = cached_key(user.id, destroyed_payload)
      EventStreamConnection.notify(channel, guid)
    end
  end

  private

  def cached_key(scoped_id, payload)
    Sidekiq.redis do |redis|
      guid = SecureRandom.uuid
      key = "event_stream::#{scoped_id}::#{guid}"
      redis.set(key, payload)
      guid
    end
  end

  def payload_for(user)
    serializer = record.event_stream_serializer(user)
    serializer.as_json.merge(action: action, subscription_name: subscription_name).to_json
  end

  def destroyed_payload
    { action: "destroyed",
      type: record.class.base_class.name.demodulize.tableize,
      ids: [record.id],
      subscription_name: subscription_name
    }.to_json
  end
end
