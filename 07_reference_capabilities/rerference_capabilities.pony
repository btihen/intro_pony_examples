  actor Main 
    new create(env : Env) =>
      let a : String iso = "hello".clone()  // only one reference
      let b = consume a                     // destroy the first alias and make a new one
      // print is a behavior so it needs a read-only val
      env.out.print( consume b )            // destroy the local alias and send off to print
 
      // String(100) creates a string length of 100 as a ref
      let c = recover iso String(100) end   // recover - converts the ref into an iso!
      c.append("bye")                       // still writable
      env.out.print( consume c )            // consume iso and send as a val to print()
