##
# Access redis anywhere from Rails app.
# 
# you dont actually need to global variable,
# use singleton redis method
Redis.current

# or wrap it in method
def redis
  Redis.current
end


##
# Delete all records in redis by wildcard
def delete_by(wildcard)
  redis.keys(wildcard).each do |key|
    redis.del(key)
  end
end