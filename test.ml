open Core_kernel
open Bap_main
open Bap.Std

let counter = object
  inherit [int * int] Term.visitor
  method! enter_term _ _ (jmps,total) = jmps,total+1
  method! enter_jmp _ (jmps,total) = jmps+1,total
end

let main proj =
  let jmps,total = counter#run (Project.program proj) (0,0) in
  printf "ratio = %d/%d = %g\n" jmps total (float jmps /. float total)

let () = Extension.declare @@ fun _ctxt ->
   Project.register_pass' main;
   Ok ()
