// Classes have functions (synchronous actions), No State (variables) nor creators
// not multithreaded!
primitive Math 
  fun double(a : I32) : I32 => a * 2
  fun trouble(a : I32, b : I32) : I32 => double(a) * double(b)

actor Main
  let _out : OutStream
  let first : I32 = 2
  let second : I32 = 3
  // var means the pointer can be reassinged
  var answer : I32
  
  new create(env : Env) =>
    _out = env.out
    env.out.print("Primitive Math")

    answer = Math.double(first)
    // print deals with strings so the answer (I32) must be converted to a string!
    env.out.print("Twice 2 is " + answer.string())

    // not just changing the value but new alias too!
    answer = Math.trouble(first, second)
    env.out.print("Trouble of 2 & 3 is " + answer.string())

    env.out.print("Twice 2 " + Math.double(2).string())
    env.out.print("Trouble of 2 & 3" + Math.trouble(2, 3).string())