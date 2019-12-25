primitive Black fun apply(): U16 => 0x0000
primitive Red   fun apply(): U16 => 0x0f00
primitive Green fun apply(): U16 => 0x00f0
primitive Blue  fun apply(): U16 => 0x000f
primitive White fun apply(): U16 => 0x0fff

type Color is (Black | White | Red | Green | Blue)

// Match on the constant values!
primitive ColorHex
  fun to_s(c: U16): String =>
    match c
    | Black() => "0x0000"
    | Red()   => "0x0f00"
    | Green() => "0x00f0"
    | Blue()  => "0x000f"
    | White() => "0x0fff"
    else
      "0x0fff"
    end

// Match on constants
primitive ColorStr
  fun to_s(c: Color): String =>
    match c
    | Black => "0x0000"
    | Red   => "0x0f00"
    | Green => "0x00f0"
    | Blue  => "0x000f"
    | White => "0x0fff"
    end

actor Main

  new create(env: Env) =>
    // White() - get the value from the constant
    env.out.print(White().string())
    env.out.print( ColorHex.to_s(White()) )

    env.out.print("-----")

    // This is just the constant
    let color' = Red 
    // Using the contant match
    env.out.print( ColorStr.to_s(color') )
    // getting the value out of the alias to the constant
    env.out.print( color'.apply().string() )

    env.out.print("-----")

    // create an array of Constants (using the enumerable)
    let colors : Array[Color] = [Red; Green; Blue; White]

    // converts the array values into an iterator 
    let iterator = colors.values()

    // iterating through the iterator values
    for color in iterator do
      // everything is an expression so this complicated if statement is allowed
      env.out.print( if color is Green then "green" else "not green" end )
    end
    env.out.print("-----")
    // a union Array of colors or numbers (using unsigned 64 bits)
    // U64(150) is an example of casting
    let things : Array[(Color | U64)] = [Red; U64(3); Green; U64(100); Blue]

    // simple one step iterator
    for thing in things.values() do 
      // matching on different types
      let out_string = match thing 
                          | 100 => "hundred"
                          | let n: U64 => n.string() 
                          | Green => "Green!"
                          else "Hmmm"
                        end
      env.out.print(out_string)
    end
