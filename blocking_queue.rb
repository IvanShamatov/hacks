class BlockingQueue < Queue

  ## Extending Queue class to have an ability to prevent adding
  #  objects to queue 
  # 
  #  Please note this code will not work in jRuby, 
  #  because Queue in jruby doesn't have @mutex, but synchronize using Java core functionality 
  # 
  #  Example:
  #  q = BlockingQueue.new
  #   => #<BlockingQueue:0x007fc00ca750c0 @blocked=false, @que=[], @waiting=[], @mutex=#<Mutex:0x007fc00ca74ff8>> 
  #  q << "a"
  #   => nil 
  #  q
  #   => #<BlockingQueue:0x007fc00ca750c0 @blocked=false, @que=["a"], @waiting=[], @mutex=#<Mutex:0x007fc00ca74ff8>> 
  #  q.block
  #   => true 
  #  q << "b"
  #   RuntimeError: Nothing can be added to queue. Queue is blocked.
  #      from (irb):21:in `push'
  #  q
  #   => #<BlockingQueue:0x007fc00ca750c0 @blocked=true, @que=["a"], @waiting=[], @mutex=#<Mutex:0x007fc00ca74ff8>> 
  #  q.open
  #   => false 
  #  q << "c"
  #   => nil 
  #  q
  #   => #<BlockingQueue:0x007fc00ca750c0 @blocked=false, @que=["a", "c"], @waiting=[], @mutex=#<Mutex:0x007fc00ca74ff8>> 

  def initialize
    @blocked = false
    super
  end


  # Overriding push method of queue
  def push(obj)
    if @blocked
      raise "Nothing can be added to queue. Queue is blocked."
    else
      super(obj)
    end
  end


  # Adding aliases to save compatibility
  alias << push
  alias enq push

  
  # Blocking queue
  def block
    @mutex.synchronize do
      @blocked = true
    end
  end


  # Opening queue
  def open
    @mutex.synchronize do
      @blocked = false
    end
  end

end