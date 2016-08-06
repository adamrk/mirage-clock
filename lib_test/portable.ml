let (>>=) = Lwt.bind

let print_time c =
  let d, ps = Pclock.now_d_ps c in
  Printf.printf "The time is %d days and %Ld picoseconds since the epoch.\n" d ps

let print_offset c = match Pclock.current_tz_offset_s c with
  | Some offset -> Printf.printf "The offset from UTC is %d minutes.\n" offset
  | None -> Printf.printf "Clock UTC offset unavailable\n"

let print_period c = match Pclock.period_d_ps c with
  | Some (d, ps) -> Printf.printf "The clock period is: %Ld picoseconds\n" ps
  | None -> Printf.printf "Clock period unavailable\n"

let print_mtime c =
  Printf.printf "Monotonic clock says: %Ld nanoseconds\n" (Mclock.elapsed_ns c)

let print_period_mono c = match Mclock.period_ns c with
  | Some ns -> Printf.printf "The monotonic clock period is: %Ld nanoseconds\n" ns
  | None -> Printf.printf "Monotonic clock period unavailable\n"

let main () =
  Mclock.connect () >>= function
  `Ok mclock -> (Pclock.connect () >>= function
    `Ok clock -> (
      print_mtime mclock;
      print_time clock;
      print_time clock;
      print_time clock;
      print_offset clock;
      print_period clock;
      print_mtime mclock;
      print_period_mono mclock;
      Lwt.return_unit
    )
    | `Error _ -> Lwt.return_unit)
  | `Error _ -> Lwt.return_unit
let _ = Lwt_main.run (main ())
