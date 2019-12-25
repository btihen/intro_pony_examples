// C FFI 
// This creates a window using C
use "lib::SDL2" 
use @SDL_Init[I32](flags : U32)
use @SDL_CreateWindow[Pointer[_SDLWindow]](
        title : Pointer[U8] tag, 
        x : I32, y : I32, w : I32, h : I32,
        flags: U32)
use @SDL_GetError[Pointer[U8]]()
use @SDL_Delay[None](ms : U32)

primitive _SDLWindow 
primitive Video fun apply() : U32 => 0x20
primitive Shown fun apply() : U32 => 0x4

actor Main 
  new create(env : ENV) => 
    if @SDL_Init(Video()) != 0 then 
      env.err.print(recover val String.copy_cstring(@SDL_GerError()) end)
      env.exitcode(1)
      return 
    end
    let title = "Pony calling C".cstring() 
    let win = @SDL_createWindow(title, -1, -1, 640, 480, Shown())
    @SDL_Delay(3000)