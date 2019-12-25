// primitives can act like class methods
// adds two separate vectors together & creates a new one
primitive VectorMath 
  fun add(a : Vect, b : Vect) : Vect =>
    // create a new vector 
    Vect(a.x + b.x, a.y + b.y)

class Vect
  var x : F32
  var y : F32

  // 32 bit Floating point
  new create(x' : F32, y' : F32) => 
    x = x'
    y = y'

  // this class must add to the current vector
  fun add(b : Vect) : Vect => 
    // this function creates a new vector adding the respective components
    Vect(x + b.x, y + b.y)

  fun to_s() : String =>
    "(" + x.string() + ", " + y.string() + ")"

actor Main
  let vect_a : Vect 
  let vect_b : Vect
  var vect_c : Vect
  
  new create(env : Env) =>
    vect_a = Vect(1,2)
    vect_b = Vect(3,4)

    vect_c = vect_a.add(vect_b)
    env.out.print("Vector A + B: " + vect_c.to_s())

    vect_c = VectorMath.add(vect_a, vect_b)
    env.out.print("Vector A + B: " + vect_c.to_s())