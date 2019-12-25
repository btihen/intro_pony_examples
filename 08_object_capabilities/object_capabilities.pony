// Object Capabilities - controls permissions (file, network -permissions)

primitive NetAuth 
  new create(from : AmbientAuth) => None 

primitive TCPAuth
  new create(from: (AmbientAuth | NetAuth)) => None 

primitive TCPListenAuth 
  new create(from: (AmbientAuth | NetAuth | TCPListenAuth)) => None 

// need to test with code