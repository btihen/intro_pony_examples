// Classes have functions (synchronous actions), State (variables), and creators
// No Behaviors -- not multithreaded!
class Cat 
  // let mean it can only have one alias assignment
  // like final in Java
  let name : String
  // var mean the alias may change
  // _ mean the variable is a private scope
  // I32 - 32 bit integer definition
  var _mood : I32 = 0

  // default contructor
  new create(name' : String) =>
    name = name'

  // override contructor
  new moody(name' : String, mood : I32) =>
    name = name' 
    _mood = mood 

  // functions behave synchronously!
  fun is_happy() : Bool => _mood > 0
  fun is_grumpy() : Bool => _mood < 0
  fun is_neutral() : Bool => _mood is 0
 
  // OutStream is the output mechanism (which must be passed from main gotten from env.out)
  fun sound(out : OutStream) => 
    if is_happy() then
      out.print("prrr")
    elseif is_grumpy() then
      out.print("hiss")
    else 
      out.print("meow")
    end

  fun talk(out : OutStream) => 
    if (_mood < 0) then
      out.print("hiss")
    elseif (_mood is 0) then
      out.print("meow")
    else 
      out.print("prrr")
    end

actor Main
  let _out : OutStream
  
  new create(env : Env) =>
    _out = env.out
    _out.print("Classy Cat")

    // syntax for default creator Cat("kitty") is the same as Cat.create("kitty")
    let neutral_cat : Cat = Cat("neutral")
    neutral_cat.talk(_out)
    neutral_cat.sound(_out)

    // secondary creators must use the full api
    let happy_cat : Cat = Cat.moody("happy", 8)
    happy_cat.talk(_out)
    happy_cat.sound(_out)

    let upset_cat : Cat = Cat.moody("upset", -8)
    upset_cat.talk(_out)    
    upset_cat.sound(_out)