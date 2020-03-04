(** Generated by coq-of-ocaml *)
Require Import OCaml.OCaml.

Local Set Primitive Projections.
Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Open Scope type_scope.
Import ListNotations.
Unset Positivity Checking.
Unset Guard Checking.

Require Import Tezos.Environment.
Import Environment.Notations.

Definition StringMap :=
  Map.Make
    (existT (A := Set) _ _
      {|
        Compare.COMPARABLE.compare := String.compare
      |}).

Module ConstructorRecords_description.
  Module description.
    Module Value.
      Record record {get encoding : Set} : Set := Build {
        get : get;
        encoding : encoding }.
      Arguments record : clear implicits.
      Definition with_get {t_get t_encoding} get
        (r : record t_get t_encoding) :=
        Build t_get t_encoding get r.(encoding).
      Definition with_encoding {t_get t_encoding} encoding
        (r : record t_get t_encoding) :=
        Build t_get t_encoding r.(get) encoding.
    End Value.
    Definition Value_skeleton := Value.record.
    
    Module IndexedDir.
      Record record {arg arg_encoding list subdir : Set} : Set := Build {
        arg : arg;
        arg_encoding : arg_encoding;
        list : list;
        subdir : subdir }.
      Arguments record : clear implicits.
      Definition with_arg {t_arg t_arg_encoding t_list t_subdir} arg
        (r : record t_arg t_arg_encoding t_list t_subdir) :=
        Build t_arg t_arg_encoding t_list t_subdir arg r.(arg_encoding) r.(list)
          r.(subdir).
      Definition with_arg_encoding {t_arg t_arg_encoding t_list t_subdir}
        arg_encoding (r : record t_arg t_arg_encoding t_list t_subdir) :=
        Build t_arg t_arg_encoding t_list t_subdir r.(arg) arg_encoding r.(list)
          r.(subdir).
      Definition with_list {t_arg t_arg_encoding t_list t_subdir} list
        (r : record t_arg t_arg_encoding t_list t_subdir) :=
        Build t_arg t_arg_encoding t_list t_subdir r.(arg) r.(arg_encoding) list
          r.(subdir).
      Definition with_subdir {t_arg t_arg_encoding t_list t_subdir} subdir
        (r : record t_arg t_arg_encoding t_list t_subdir) :=
        Build t_arg t_arg_encoding t_list t_subdir r.(arg) r.(arg_encoding)
          r.(list) subdir.
    End IndexedDir.
    Definition IndexedDir_skeleton := IndexedDir.record.
  End description.
End ConstructorRecords_description.
Import ConstructorRecords_description.

Reserved Notation "'description.Value".
Reserved Notation "'description.IndexedDir".
Reserved Notation "'t".

Inductive description (key : Set) : Set :=
| Empty : description key
| Value : forall {a : Set}, 'description.Value a key -> description key
| NamedDir : (|StringMap|).(S.MAP.t) ('t key) -> description key
| IndexedDir : forall {a : Set},
  'description.IndexedDir a key -> description key

where "'t" := (fun (t_key : Set) => Pervasives.ref (description t_key))
and "'description.Value" := (fun (t_a t_key : Set) =>
  description.Value_skeleton
    (t_key -> Lwt.t (Error_monad.tzresult (option t_a))) (Data_encoding.t t_a))
and "'description.IndexedDir" := (fun (t_a t_key : Set) =>
  description.IndexedDir_skeleton (RPC_arg.t t_a) (Data_encoding.t t_a)
    (t_key -> Lwt.t (Error_monad.tzresult (list t_a))) ('t (t_key * t_a))).

Module description.
  Include ConstructorRecords_description.description.
  Definition Value := 'description.Value.
  Definition IndexedDir := 'description.IndexedDir.
End description.

Definition t := 't.

Arguments Empty {_}.
Arguments Value {_ _}.
Arguments NamedDir {_}.
Arguments IndexedDir {_ _}.

Fixpoint register_named_subcontext {r : Set} (dir : t r) (names : list string)
  {struct dir} : t r :=
  match ((Pervasives.op_exclamation dir), names) with
  | (_, []) => dir
  | (Value _, _) => Pervasives.invalid_arg ""
  | (IndexedDir _, _) => Pervasives.invalid_arg ""
  | (Empty, cons name names) =>
    let subdir := Pervasives.__ref_value Empty in
    (* ❌ Sequences of instructions are ignored (operator ";") *)
    (* ❌ instruction_sequence ";" *)
    register_named_subcontext subdir names
  | (NamedDir map, cons name names) =>
    let subdir :=
      match (|StringMap|).(S.MAP.find_opt) name map with
      | Some subdir => subdir
      | None =>
        let subdir := Pervasives.__ref_value Empty in
        (* ❌ Sequences of instructions are ignored (operator ";") *)
        (* ❌ instruction_sequence ";" *)
        subdir
      end in
    register_named_subcontext subdir names
  end.

Module ConstructorRecords_args.
  Module args.
    Module One.
      Record record {rpc_arg encoding compare : Set} : Set := Build {
        rpc_arg : rpc_arg;
        encoding : encoding;
        compare : compare }.
      Arguments record : clear implicits.
      Definition with_rpc_arg {t_rpc_arg t_encoding t_compare} rpc_arg
        (r : record t_rpc_arg t_encoding t_compare) :=
        Build t_rpc_arg t_encoding t_compare rpc_arg r.(encoding) r.(compare).
      Definition with_encoding {t_rpc_arg t_encoding t_compare} encoding
        (r : record t_rpc_arg t_encoding t_compare) :=
        Build t_rpc_arg t_encoding t_compare r.(rpc_arg) encoding r.(compare).
      Definition with_compare {t_rpc_arg t_encoding t_compare} compare
        (r : record t_rpc_arg t_encoding t_compare) :=
        Build t_rpc_arg t_encoding t_compare r.(rpc_arg) r.(encoding) compare.
    End One.
    Definition One_skeleton := One.record.
  End args.
End ConstructorRecords_args.
Import ConstructorRecords_args.

Reserved Notation "'args.One".

Inductive args : Set :=
| One : forall {a : Set}, 'args.One a -> args
| Pair : args -> args -> args

where "'args.One" := (fun (t_a : Set) =>
  args.One_skeleton (RPC_arg.t t_a) (Data_encoding.t t_a) (t_a -> t_a -> int)).

Module args.
  Include ConstructorRecords_args.args.
  Definition One := 'args.One.
End args.

Fixpoint unpack {a b c : Set} (v : args) (x : c) {struct v} : a * b :=
  match v with
  | One _ => cast (a * b) x
  | Pair l __r_value =>
    let '[l, __r_value] := cast [args ** args] [l, __r_value] in
    cast (a * b)
    (let '(c, d) := (unpack (a := unit) (b := unit)) __r_value x in
    let '(__b_value, __a_value) := (unpack (a := unit) (b := unit)) l c in
    (__b_value, (__a_value, d)))
  end.

Fixpoint __pack {a b c : Set} (v : args) (x : a) (y : b) {struct v} : c :=
  match (v, y) with
  | (One _, _) => cast c (x, y)
  | (Pair l __r_value, _ as y) =>
    let 'existT _ [__0, __1] [l, __r_value, y] :=
      cast_exists (Es := [Set ** Set])
        (fun '[__0, __1] => [args ** args ** __0 * __1]) [l, __r_value, y] in
    cast c
    (let '(__a_value, d) := y in
    let c := (__pack (c := unit)) l x __a_value in
    (__pack (c := unit)) __r_value c d)
  end.

Fixpoint compare {b : Set} (v : args) (x1 : b) (x2 : b) {struct v} : int :=
  match (v, x1, x2) with
  | (One {| args.One.compare := compare' |}, _, _) =>
    let compare' := cast (b -> b -> int) compare' in
    compare' x1 x2
  | (Pair l __r_value, _ as x1, _ as x2) =>
    let 'existT _ [__0, __1] [l, __r_value, x1, x2] :=
      cast_exists (Es := [Set ** Set])
        (fun '[__0, __1] => [args ** args ** __0 * __1 ** __0 * __1])
        [l, __r_value, x1, x2] in
    let '(a1, b1) := x1 in
    let '(a2, b2) := x2 in
    match compare l a1 a2 with
    | 0 => compare __r_value b1 b2
    | x => x
    end
  end.

Definition destutter {A B : Set} (equal : A -> A -> bool) (l : list (A * B))
  : list A :=
  match l with
  | [] => nil
  | cons (i, _) l =>
    let fix loop {C : Set}
      (acc : list A) (i : A) (function_parameter : list (A * C)) {struct acc}
      : list A :=
      match function_parameter with
      | [] => acc
      | cons (j, _) l =>
        if equal i j then
          loop acc i l
        else
          loop (cons j acc) j l
      end in
    loop [ i ] i l
  end.

Fixpoint register_indexed_subcontext {a b r : Set}
  (dir : t r) (__list_value : r -> Lwt.t (Error_monad.tzresult (list a)))
  (path : args) {struct dir} : t b :=
  match (path, __list_value) with
  | (Pair __left __right, _ as __list_value) =>
    let 'existT _ [__0, __1] [__left, __right, __list_value] :=
      cast_exists (Es := [Set ** Set])
        (fun '[__0, __1] =>
          [args ** args ** r -> Lwt.t (Error_monad.tzresult (list (__0 * __1)))])
        [__left, __right, __list_value] in
    let compare_left := compare __left in
    let equal_left (x : __0) (y : __0) : bool :=
      (|Compare.Int|).(Compare.S.op_eq) (compare_left x y) 0 in
    let list_left (__r_value : r) : Lwt.t (Error_monad.tzresult (list __0)) :=
      let=? l := __list_value __r_value in
      Error_monad.__return (destutter equal_left l) in
    register_indexed_subcontext
      (register_indexed_subcontext dir list_left __left)
      (fun __r_value =>
        let '(__a_value, k) := (unpack (c := unit)) __left __r_value in
        let=? l := __list_value __a_value in
        Error_monad.__return
          (List.map Pervasives.snd
            (List.filter
              (fun function_parameter =>
                let '(x, _) := function_parameter in
                equal_left x k) l))) __right
  | (One {| args.One.rpc_arg := arg; args.One.encoding := arg_encoding |}, _) =>
    let '[arg, arg_encoding] :=
      cast [RPC_arg.t a ** Data_encoding.t a] [arg, arg_encoding] in
    match Pervasives.op_exclamation dir with
    | Value _ => Pervasives.invalid_arg ""
    | NamedDir _ => Pervasives.invalid_arg ""
    | Empty =>
      let subdir := Pervasives.__ref_value Empty in
      (* ❌ Sequences of instructions are ignored (operator ";") *)
      (* ❌ instruction_sequence ";" *)
      subdir
    |
      IndexedDir {|
        description.IndexedDir.arg := inner_arg;
          description.IndexedDir.subdir := subdir
          |} =>
      let 'existT _ __IndexedDir_'a [inner_arg, subdir] :=
        existT (A := Set)
          (fun __IndexedDir_'a =>
            [RPC_arg.t __IndexedDir_'a ** t (r * __IndexedDir_'a)]) _
          [inner_arg, subdir] in
      match RPC_arg.__eq_value arg inner_arg with
      | None => cast (t b) ((Pervasives.invalid_arg (a := t b)) "")
      | Some RPC_arg.Eq => cast (t b) subdir
      end
    end
  end.

Definition register_value {a b : Set}
  (dir : t a) (get : a -> Lwt.t (Error_monad.tzresult (option b)))
  (encoding : Data_encoding.t b) : unit :=
  match Pervasives.op_exclamation dir with
  | Empty =>
    Pervasives.op_coloneq dir
      (Value
        {| description.Value.get := get; description.Value.encoding := encoding
          |})
  | _ => Pervasives.invalid_arg ""
  end.

Definition create {A : Set} (function_parameter : unit)
  : Pervasives.ref (description A) :=
  let '_ := function_parameter in
  Pervasives.__ref_value Empty.

Fixpoint pp {a : Set} (ppf : Format.formatter) (dir : t a) {struct ppf}
  : unit :=
  match Pervasives.op_exclamation dir with
  | Empty =>
    Format.fprintf ppf
      (CamlinternalFormatBasics.Format
        (CamlinternalFormatBasics.String_literal "EMPTY"
          CamlinternalFormatBasics.End_of_format) "EMPTY")
  | Value _e =>
    let 'existT _ __Value_'a _e :=
      existT (A := Set) (fun __Value_'a => description.Value __Value_'a a) _ _e
      in
    Format.fprintf ppf
      (CamlinternalFormatBasics.Format
        (CamlinternalFormatBasics.String_literal "Value"
          CamlinternalFormatBasics.End_of_format) "Value")
  | NamedDir map =>
    Format.fprintf ppf
      (CamlinternalFormatBasics.Format
        (CamlinternalFormatBasics.Formatting_gen
          (CamlinternalFormatBasics.Open_box
            (CamlinternalFormatBasics.Format
              (CamlinternalFormatBasics.String_literal "<v>"
                CamlinternalFormatBasics.End_of_format) "<v>"))
          (CamlinternalFormatBasics.Alpha
            (CamlinternalFormatBasics.Formatting_lit
              CamlinternalFormatBasics.Close_box
              CamlinternalFormatBasics.End_of_format))) "@[<v>%a@]")
      (Format.pp_print_list None pp_item) ((|StringMap|).(S.MAP.bindings) map)
  |
    IndexedDir {|
      description.IndexedDir.arg := arg;
        description.IndexedDir.subdir := subdir
        |} =>
    let 'existT _ __IndexedDir_'a [arg, subdir] :=
      existT (A := Set)
        (fun __IndexedDir_'a =>
          [RPC_arg.t __IndexedDir_'a ** t (a * __IndexedDir_'a)]) _
        [arg, subdir] in
    let name :=
      Format.asprintf
        (CamlinternalFormatBasics.Format
          (CamlinternalFormatBasics.Char_literal "<" % char
            (CamlinternalFormatBasics.String CamlinternalFormatBasics.No_padding
              (CamlinternalFormatBasics.Char_literal ">" % char
                CamlinternalFormatBasics.End_of_format))) "<%s>")
        (RPC_arg.__descr_value arg).(RPC_arg.descr.name) in
    pp_item ppf (name, subdir)
  end

with pp_item {a : Set}
  (ppf : Format.formatter) (function_parameter : string * t a) {struct ppf}
  : unit :=
  let '(name, dir) := function_parameter in
  Format.fprintf ppf
    (CamlinternalFormatBasics.Format
      (CamlinternalFormatBasics.Formatting_gen
        (CamlinternalFormatBasics.Open_box
          (CamlinternalFormatBasics.Format
            (CamlinternalFormatBasics.String_literal "<v 2>"
              CamlinternalFormatBasics.End_of_format) "<v 2>"))
        (CamlinternalFormatBasics.String CamlinternalFormatBasics.No_padding
          (CamlinternalFormatBasics.Formatting_lit
            (CamlinternalFormatBasics.Break "@ " 1 0)
            (CamlinternalFormatBasics.Alpha
              (CamlinternalFormatBasics.Formatting_lit
                CamlinternalFormatBasics.Close_box
                CamlinternalFormatBasics.End_of_format))))) "@[<v 2>%s@ %a@]")
    name pp dir.

Module INDEX.
  Record signature {t : Set} : Set := {
    t := t;
    path_length : int;
    to_path : t -> list string -> list string;
    of_path : list string -> option t;
    rpc_arg : RPC_arg.t t;
    encoding : Data_encoding.t t;
    compare : t -> t -> int;
  }.
  Arguments signature : clear implicits.
End INDEX.

Module ConstructorRecords_handler.
  Module handler.
    Module Handler.
      Record record {encoding get : Set} : Set := Build {
        encoding : encoding;
        get : get }.
      Arguments record : clear implicits.
      Definition with_encoding {t_encoding t_get} encoding
        (r : record t_encoding t_get) :=
        Build t_encoding t_get encoding r.(get).
      Definition with_get {t_encoding t_get} get
        (r : record t_encoding t_get) :=
        Build t_encoding t_get r.(encoding) get.
    End Handler.
    Definition Handler_skeleton := Handler.record.
  End handler.
End ConstructorRecords_handler.
Import ConstructorRecords_handler.

Reserved Notation "'handler.Handler".

Inductive handler (key : Set) : Set :=
| Handler : forall {a : Set}, 'handler.Handler a key -> handler key

where "'handler.Handler" := (fun (t_a t_key : Set) =>
  handler.Handler_skeleton (Data_encoding.t t_a)
    (t_key -> int -> Lwt.t (Error_monad.tzresult t_a))).

Module handler.
  Include ConstructorRecords_handler.handler.
  Definition Handler := 'handler.Handler.
End handler.

Arguments Handler {_ _}.

Module ConstructorRecords_opt_handler.
  Module opt_handler.
    Module Opt_handler.
      Record record {encoding get : Set} : Set := Build {
        encoding : encoding;
        get : get }.
      Arguments record : clear implicits.
      Definition with_encoding {t_encoding t_get} encoding
        (r : record t_encoding t_get) :=
        Build t_encoding t_get encoding r.(get).
      Definition with_get {t_encoding t_get} get
        (r : record t_encoding t_get) :=
        Build t_encoding t_get r.(encoding) get.
    End Opt_handler.
    Definition Opt_handler_skeleton := Opt_handler.record.
  End opt_handler.
End ConstructorRecords_opt_handler.
Import ConstructorRecords_opt_handler.

Reserved Notation "'opt_handler.Opt_handler".

Inductive opt_handler (key : Set) : Set :=
| Opt_handler : forall {a : Set},
  'opt_handler.Opt_handler a key -> opt_handler key

where "'opt_handler.Opt_handler" := (fun (t_a t_key : Set) =>
  opt_handler.Opt_handler_skeleton (Data_encoding.t t_a)
    (t_key -> int -> Lwt.t (Error_monad.tzresult (option t_a)))).

Module opt_handler.
  Include ConstructorRecords_opt_handler.opt_handler.
  Definition Opt_handler := 'opt_handler.Opt_handler.
End opt_handler.

Arguments Opt_handler {_ _}.

Fixpoint combine_object {A : Set}
  (function_parameter : list (string * opt_handler A))
  {struct function_parameter} : handler A :=
  match function_parameter with
  | [] =>
    Handler
      {| handler.Handler.encoding := Data_encoding.__unit_value;
        handler.Handler.get :=
          fun function_parameter =>
            let '_ := function_parameter in
            fun function_parameter =>
              let '_ := function_parameter in
              Error_monad.return_unit |}
  | cons (name, Opt_handler __handler_value) fields =>
    let 'existT _ __Opt_handler_'a [name, __handler_value, fields] :=
      existT (A := Set)
        (fun __Opt_handler_'a =>
          [string ** opt_handler.Opt_handler __Opt_handler_'a A **
            list (string * opt_handler A)]) _ [name, __handler_value, fields] in
    let 'Handler handlers := combine_object fields in
    let 'existT _ __Handler_'a handlers :=
      existT (A := Set) (fun __Handler_'a => handler.Handler __Handler_'a A) _
        handlers in
    Handler
      {|
        handler.Handler.encoding :=
          Data_encoding.merge_objs
            (Data_encoding.obj1
              (Data_encoding.opt None None name
                (Data_encoding.dynamic_size None
                  __handler_value.(opt_handler.Opt_handler.encoding))))
            handlers.(handler.Handler.encoding);
        handler.Handler.get :=
          fun k =>
            fun i =>
              let=? v1 := __handler_value.(opt_handler.Opt_handler.get) k i in
              let=? v2 := handlers.(handler.Handler.get) k i in
              Error_monad.__return (v1, v2) |}
  end.

Module query.
  Record record : Set := Build {
    depth : int }.
  Definition with_depth depth (r : record) :=
    Build depth.
End query.
Definition query := query.record.

Definition depth_query : RPC_query.t query :=
  RPC_query.seal
    (RPC_query.op_pipeplus
      (RPC_query.__query_value (fun depth => {| query.depth := depth |}))
      (RPC_query.__field_value None "depth" RPC_arg.__int_value 0
        (fun __t_value => __t_value.(query.depth)))).

Definition build_directory {key : Set} (dir : t key) : RPC_directory.t key :=
  let rpc_dir := Pervasives.__ref_value RPC_directory.empty in
  let register {ikey : Set}
    (path : RPC_path.t key ikey) (function_parameter : opt_handler ikey)
    : unit :=
    let
      'Opt_handler {|
        opt_handler.Opt_handler.encoding := encoding;
          opt_handler.Opt_handler.get := get
          |} := function_parameter in
    let 'existT _ __Opt_handler_'a [encoding, get] :=
      existT (A := Set)
        (fun __Opt_handler_'a =>
          [Data_encoding.t __Opt_handler_'a **
            ikey -> int ->
            Lwt.t (Error_monad.tzresult (option __Opt_handler_'a))]) _
        [encoding, get] in
    let service := RPC_service.get_service None depth_query encoding path in
    Pervasives.op_coloneq rpc_dir
      (RPC_directory.register (Pervasives.op_exclamation rpc_dir) service
        (fun k =>
          fun q =>
            fun function_parameter =>
              let '_ := function_parameter in
              let=? function_parameter :=
                get k (Pervasives.op_plus q.(query.depth) 1) in
              match function_parameter with
              | None => Pervasives.raise extensible_type_value
              | Some x => Error_monad.__return x
              end)) in
  let fix build_handler {ikey : Set} (dir : t ikey) (path : RPC_path.t key ikey)
    {struct dir} : opt_handler ikey :=
    match Pervasives.op_exclamation dir with
    | Empty =>
      Opt_handler
        {| opt_handler.Opt_handler.encoding := Data_encoding.__unit_value;
          opt_handler.Opt_handler.get :=
            fun function_parameter =>
              let '_ := function_parameter in
              fun function_parameter =>
                let '_ := function_parameter in
                Error_monad.return_none |}
    |
      Value {|
        description.Value.get := get;
          description.Value.encoding := encoding
          |} =>
      let 'existT _ __Value_'a [get, encoding] :=
        existT (A := Set)
          (fun __Value_'a =>
            [ikey -> Lwt.t (Error_monad.tzresult (option __Value_'a)) **
              Data_encoding.t __Value_'a]) _ [get, encoding] in
      let __handler_value :=
        Opt_handler
          {| opt_handler.Opt_handler.encoding := encoding;
            opt_handler.Opt_handler.get :=
              fun k =>
                fun i =>
                  if (|Compare.Int|).(Compare.S.op_lt) i 0 then
                    Error_monad.return_none
                  else
                    get k |} in
      (* ❌ Sequences of instructions are ignored (operator ";") *)
      (* ❌ instruction_sequence ";" *)
      __handler_value
    | NamedDir map =>
      let fields := (|StringMap|).(S.MAP.bindings) map in
      let fields :=
        List.map
          (fun function_parameter =>
            let '(name, dir) := function_parameter in
            (name, (build_handler dir (RPC_path.op_div path name)))) fields in
      let 'Handler __handler_value := combine_object fields in
      let 'existT _ __Handler_'a __handler_value :=
        existT (A := Set)
          (fun __Handler_'a => handler.Handler __Handler_'a ikey) _
          __handler_value in
      let __handler_value :=
        Opt_handler
          {|
            opt_handler.Opt_handler.encoding :=
              __handler_value.(handler.Handler.encoding);
            opt_handler.Opt_handler.get :=
              fun k =>
                fun i =>
                  if (|Compare.Int|).(Compare.S.op_lt) i 0 then
                    Error_monad.return_none
                  else
                    let=? v :=
                      __handler_value.(handler.Handler.get) k
                        (Pervasives.op_minus i 1) in
                    Error_monad.return_some v |} in
      (* ❌ Sequences of instructions are ignored (operator ";") *)
      (* ❌ instruction_sequence ";" *)
      __handler_value
    |
      IndexedDir {|
        description.IndexedDir.arg := arg;
          description.IndexedDir.arg_encoding := arg_encoding;
          description.IndexedDir.list := __list_value;
          description.IndexedDir.subdir := subdir
          |} =>
      let 'existT _ __IndexedDir_'a [arg, arg_encoding, __list_value, subdir] :=
        existT (A := Set)
          (fun __IndexedDir_'a =>
            [RPC_arg.t __IndexedDir_'a ** Data_encoding.t __IndexedDir_'a **
              ikey -> Lwt.t (Error_monad.tzresult (list __IndexedDir_'a)) **
              t (ikey * __IndexedDir_'a)]) _
          [arg, arg_encoding, __list_value, subdir] in
      let 'Opt_handler __handler_value :=
        build_handler subdir (RPC_path.op_divcolon path arg) in
      let 'existT _ __Opt_handler_'a1 __handler_value :=
        existT (A := Set)
          (fun __Opt_handler_'a1 =>
            opt_handler.Opt_handler __Opt_handler_'a1 (ikey * __IndexedDir_'a))
          _ __handler_value in
      let encoding :=
        Data_encoding.union None
          [
            Data_encoding.__case_value "Leaf" None (Data_encoding.Tag 0)
              (Data_encoding.dynamic_size None arg_encoding)
              (fun function_parameter =>
                match function_parameter with
                | (__key_value, None) => Some __key_value
                | _ => None
                end) (fun __key_value => (__key_value, None));
            Data_encoding.__case_value "Dir" None (Data_encoding.Tag 1)
              (Data_encoding.tup2
                (Data_encoding.dynamic_size None arg_encoding)
                (Data_encoding.dynamic_size None
                  __handler_value.(opt_handler.Opt_handler.encoding)))
              (fun function_parameter =>
                match function_parameter with
                | (__key_value, Some value) =>
                  Some (__key_value, value)
                | _ => None
                end)
              (fun function_parameter =>
                let '(__key_value, value) := function_parameter
                  in
                (__key_value, (Some value)))
          ] in
      let get (k : ikey) (i : (|Compare.Int|).(Compare.S.t))
        : Lwt.t
          (Error_monad.tzresult
            (option (list (__IndexedDir_'a * option __Opt_handler_'a1)))) :=
        if (|Compare.Int|).(Compare.S.op_lt) i 0 then
          Error_monad.return_none
        else
          if (|Compare.Int|).(Compare.S.op_eq) i 0 then
            Error_monad.return_some nil
          else
            let=? keys := __list_value k in
            let=? values :=
              Error_monad.map_s
                (fun __key_value =>
                  if (|Compare.Int|).(Compare.S.op_eq) i 1 then
                    Error_monad.__return (__key_value, None)
                  else
                    let=? value :=
                      __handler_value.(opt_handler.Opt_handler.get)
                        (k, __key_value) (Pervasives.op_minus i 1) in
                    Error_monad.__return (__key_value, value)) keys in
            Error_monad.return_some values in
      let __handler_value :=
        Opt_handler
          {|
            opt_handler.Opt_handler.encoding :=
              Data_encoding.__list_value None
                (Data_encoding.dynamic_size None encoding);
            opt_handler.Opt_handler.get := get |} in
      (* ❌ Sequences of instructions are ignored (operator ";") *)
      (* ❌ instruction_sequence ";" *)
      __handler_value
    end in
  (* ❌ Sequences of instructions are ignored (operator ";") *)
  (* ❌ instruction_sequence ";" *)
  Pervasives.op_exclamation rpc_dir.
