// primitives can make constants too!
primitive Happy fun apply(): I32 => 100
primitive Angry fun apply(): I32 => -100

actor Main
  var mood : I32
  
  new create(env : Env) =>
    // implicit (apply is the default)
    env.out.print(Happy().string())
    env.out.print(Angry().string())

    mood = Happy()
    env.out.print(mood.string())

    mood = Angry()
    env.out.print(mood.string())

    // fully explicit usage
    env.out.print(Happy.apply().string())
    env.out.print(Angry.apply().string())

    mood = Happy.apply()
    env.out.print(mood.string())

    mood = Angry.apply()
    env.out.print(mood.string())
