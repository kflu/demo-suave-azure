module webhello

open Suave
open System.Net
open System.Net.Sockets
[<EntryPoint>]
let main argv =
    let port = int argv.[0]
    let config = 
        { defaultConfig with 
            bindings = [HttpBinding.mkSimple HTTP "127.0.0.1" port] }
    startWebServer config (Successful.OK "Hello World!")
    0 // return an integer exit code
