Reference Capabilities control what other aliases can do (or not) with the same data.

This avoids the problem where two actors can mutate the same data (async) - leads to problems!

Aliases - name pointing at a reference 

a -\
    > data im memory
b -/

a and b both point to the same object (a & b) are aliases for object_c

There are two kinds of aliases:
- **Local Aliases** - aliases within the same actor (thread)
- **Global Aliases** - aliases to the same data between actors (threads) - this is where problems happen!

Another important criteria: 
**Sendable** - can be safely passed to another actor?

- **val** (value)     -- SENDABLE               -- all aliases are read-only  -- immutables / constants
- **ref** (reference) -- NOT SENDABLE!          -- all aliases are read/write -- variable in most languages
- **iso** (isolated)  -- SENDABLE (if consumed) -- this is the ONLY alias (read/write)

- **tag** (identity tag) -- SENDABLE            -- alias which can't read or write -- the identity of other actors (but can be stored, compared and send messages!)
- **box** (black box) -- NOT SENDABLE           -- alias is read-only, but may have read/write local aliases (or a global read-only alias) -- parameters in functions is the main use
- **trn** (transition) -- alias is read/write -- but there may be local _box_ aliases & can be converted tp a _val_ (read-only) alias (pretty rare to use) -- manulape within one actor and then covert to a val and send to other actors

## Manipulate References

- **consume** - removes local aliases so it can be sent to others to manipulate
  ```
  actor Main 
    new create(env : Env) =>
      let a : String iso = "hello".clone() // only one reference
      let b = consume a                    // destroy the first alias and make a new one
      // print is a behavior so it needs a read-only val
      env.out.print( consume b )           // destroy the local alias and send off to print
  ```
- **recover** - recover creates a scope 
  ```
  actor Main 
    new create(env : Env) => 
      let a = recover iso String(100) end   // recover to iso from ref 
      a.append("hello")                     // still writable
      env.out.print( consume a )            // consume iso and send as a val to print()
  ```

