open Containers

type t = float

let of_string s = 
  try
    Float.of_string_exn s
  with Failure _ -> 
    invalid_arg (Format.sprintf "%s.of_string" __MODULE__)

let pp fmt f =
  Format.fprintf fmt "%.10f" f