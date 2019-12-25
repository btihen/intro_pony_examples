// Generics (1 / 3)
// very powerful - here's how to create a linked list !
// Most strongly typed language - this is hard!
class List[A]
  var _item : A
  var _next : (List[A] | None) = None 

  new create(item : A) =>
    _item = consume item 

  fun apply() : this -> A => 
    _item 
  
  fun next() : (this -> List[A] | None) => 
    _next

  fun rer append(that : List[A]) => 
    if (_next is that) or (this is that) then 
      return 
    end 
    that._next = _next 
    next = that 

  fun values() : Values[A, this->List[A]]^ =>
    Values[A, this->List[A]](this)

// Generics (2 / 3)
// The Lists iterator
class Values[A, N : List[A] #read] is Iterator[N-A]
  var _next : (N | None)

  new create(head : (N | None)) =>
    _next = head 

  fun has_next() : Bool => 
    _next isnt None 

  fun ref next() : N->A ? =>
    match _next 
      | let next' : N => 
          _next = next'.next() 
          next() 
      else 
        error 
      end

// Generics ( 3 / 3) 
// usage of the generics 
actor Main 
  new create(env : Env) => 
    let l = List[String]("foo")
    l.append(List[String]("bar"))

    for item in l.values() do
      env.out.print(item)
    end

      