// import from other libraries - in this case needed for range
use "collections"

interface CounterNotify 
  be get_count(count : U32)

actor Counter 
  var _count : U32 = 0
  be get(notify: CounterNotify tag) =>
    notify.get_count(_count)
  be inc() => _count = _count + 1
  be add(amount : U32) => _count = _count + amount
  // tag will be explained later
  be get_and_reset(notify: CounterNotify tag) =>

    // sends a return message to print the value in the calling actor 'notify'
    notify.get_count(_count)

    // reset the counter
    _count = 0

// message passing in threads is a behavior 'be' only available in actors
actor Main is CounterNotify 
  let _out : OutStream
  
  new create(env : Env) =>
    _out = env.out
    _out.print("CounterNotify")

    // create the other actor
    var counter = Counter 

    // loop over the increment 10 times _ means unused value
    for _ in Range[U32](0, 10) do
      // send it increment by 1 messages 
      counter.inc()
    end

    // send it a final message to return the value and reset
    // first returned async message (after those in this main thread)
    counter.get_and_reset(this)

    _out.print("======")

    for i in Range[U32](0, 10) do
      // send it add on messages
      counter.add(i)
      // these are printed async (after this loop) - but before get_and_reset
      counter.get(this)
      // this are printed immediately in this thread
      _out.print( i.string() )
      _out.print("------")
    end
    _out.print("******")

    // send it a final message to return the value and reset
    counter.get_and_reset(this)

  // like an async print method - but central calling actor retains the env permissions
  // last returned async message - they comeback in the order sent
  be get_count(count : U32) => 
    _out.print(count.string())
