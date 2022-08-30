open Hardcaml
open Field_ops_lib

type 'a t = 'a Point.Affine.t =
  { x : 'a
  ; y : 'a
  }
[@@deriving sexp_of, hardcaml]

module With_valid : Hardcaml.Interface.S with type 'a t = ('a, 'a t) With_valid.t2
