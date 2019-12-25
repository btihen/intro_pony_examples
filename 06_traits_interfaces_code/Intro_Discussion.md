// two types of intfaces in Pony 

// is like interfaces in Java (and can have default implementations like here)
// forces the compiler to check that the interface is actually in use and used properly
trait Yummy
  fun is_delicious() : Bool => true 

// is like more like golang - a structural interface -- no default implementations
interface Edible
  fun is_edible() : Bool

interface Poisonous
  fun is_deadly() : Bool

type GreatFood is (Yummy & Edible)
type KillerFood is (Yummy & Poisonous)


// defining a new type with interfaces -- a map whose key must be hashable and comparable 
// box is a reference capability (will discuss later very important for threading/concurrency)
type Map[K: (Hashable box & Comparable[K] box), V] is HashMap[K, V, HashEq[K]]

