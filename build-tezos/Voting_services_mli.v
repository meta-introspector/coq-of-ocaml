(** Generated by coq-of-ocaml *)
Require Import OCaml.OCaml.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Open Scope type_scope.
Import ListNotations.

Unset Positivity Checking.
Unset Guard Checking.

Require Import Tezos.Environment.
Require Tezos.Alpha_context.

Import Alpha_context.

Parameter ballots : forall {E F H J K a b c i o q : Set},
  (((RPC_service.t
    ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit +
      (* `PATCH *) unit) RPC_context.t RPC_context.t q i o -> a -> q -> i ->
  Lwt.t (Error_monad.shell_tzresult o)) * (E * q * i * o)) *
    (((RPC_service.t
      ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit
        + (* `PATCH *) unit) RPC_context.t (RPC_context.t * a) q i o -> a ->
    a -> q -> i -> Lwt.t (Error_monad.shell_tzresult o)) * (F * a * q * i * o))
      *
      (((RPC_service.t
        ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
          (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
        ((RPC_context.t * a) * b) q i o -> a -> a -> b -> q -> i ->
      Lwt.t (Error_monad.shell_tzresult o)) * (H * a * b * q * i * o)) *
        (((RPC_service.t
          ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
            (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
          (((RPC_context.t * a) * b) * c) q i o -> a -> a -> b -> c -> q -> i ->
        Lwt.t (Error_monad.shell_tzresult o)) * (J * a * b * c * q * i * o)) * K))))
    * K * a -> a ->
  Lwt.t (Error_monad.shell_tzresult Alpha_context.Vote.ballots).

Parameter ballot_list : forall {E F H J K a b c i o q : Set},
  (((RPC_service.t
    ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit +
      (* `PATCH *) unit) RPC_context.t RPC_context.t q i o -> a -> q -> i ->
  Lwt.t (Error_monad.shell_tzresult o)) * (E * q * i * o)) *
    (((RPC_service.t
      ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit
        + (* `PATCH *) unit) RPC_context.t (RPC_context.t * a) q i o -> a ->
    a -> q -> i -> Lwt.t (Error_monad.shell_tzresult o)) * (F * a * q * i * o))
      *
      (((RPC_service.t
        ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
          (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
        ((RPC_context.t * a) * b) q i o -> a -> a -> b -> q -> i ->
      Lwt.t (Error_monad.shell_tzresult o)) * (H * a * b * q * i * o)) *
        (((RPC_service.t
          ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
            (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
          (((RPC_context.t * a) * b) * c) q i o -> a -> a -> b -> c -> q -> i ->
        Lwt.t (Error_monad.shell_tzresult o)) * (J * a * b * c * q * i * o)) * K))))
    * K * a -> a ->
  Lwt.t
    (Error_monad.shell_tzresult
      (list
        ((|Signature.Public_key_hash|).(S.SPublic_key_hash.t) *
          Alpha_context.Vote.ballot))).

Parameter current_period_kind : forall {E F H J K a b c i o q : Set},
  (((RPC_service.t
    ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit +
      (* `PATCH *) unit) RPC_context.t RPC_context.t q i o -> a -> q -> i ->
  Lwt.t (Error_monad.shell_tzresult o)) * (E * q * i * o)) *
    (((RPC_service.t
      ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit
        + (* `PATCH *) unit) RPC_context.t (RPC_context.t * a) q i o -> a ->
    a -> q -> i -> Lwt.t (Error_monad.shell_tzresult o)) * (F * a * q * i * o))
      *
      (((RPC_service.t
        ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
          (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
        ((RPC_context.t * a) * b) q i o -> a -> a -> b -> q -> i ->
      Lwt.t (Error_monad.shell_tzresult o)) * (H * a * b * q * i * o)) *
        (((RPC_service.t
          ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
            (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
          (((RPC_context.t * a) * b) * c) q i o -> a -> a -> b -> c -> q -> i ->
        Lwt.t (Error_monad.shell_tzresult o)) * (J * a * b * c * q * i * o)) * K))))
    * K * a -> a ->
  Lwt.t (Error_monad.shell_tzresult Alpha_context.Voting_period.kind).

Parameter current_quorum : forall {E F H J K a b c i o q : Set},
  (((RPC_service.t
    ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit +
      (* `PATCH *) unit) RPC_context.t RPC_context.t q i o -> a -> q -> i ->
  Lwt.t (Error_monad.shell_tzresult o)) * (E * q * i * o)) *
    (((RPC_service.t
      ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit
        + (* `PATCH *) unit) RPC_context.t (RPC_context.t * a) q i o -> a ->
    a -> q -> i -> Lwt.t (Error_monad.shell_tzresult o)) * (F * a * q * i * o))
      *
      (((RPC_service.t
        ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
          (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
        ((RPC_context.t * a) * b) q i o -> a -> a -> b -> q -> i ->
      Lwt.t (Error_monad.shell_tzresult o)) * (H * a * b * q * i * o)) *
        (((RPC_service.t
          ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
            (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
          (((RPC_context.t * a) * b) * c) q i o -> a -> a -> b -> c -> q -> i ->
        Lwt.t (Error_monad.shell_tzresult o)) * (J * a * b * c * q * i * o)) * K))))
    * K * a -> a -> Lwt.t (Error_monad.shell_tzresult Int32.t).

Parameter listings : forall {E F H J K a b c i o q : Set},
  (((RPC_service.t
    ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit +
      (* `PATCH *) unit) RPC_context.t RPC_context.t q i o -> a -> q -> i ->
  Lwt.t (Error_monad.shell_tzresult o)) * (E * q * i * o)) *
    (((RPC_service.t
      ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit
        + (* `PATCH *) unit) RPC_context.t (RPC_context.t * a) q i o -> a ->
    a -> q -> i -> Lwt.t (Error_monad.shell_tzresult o)) * (F * a * q * i * o))
      *
      (((RPC_service.t
        ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
          (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
        ((RPC_context.t * a) * b) q i o -> a -> a -> b -> q -> i ->
      Lwt.t (Error_monad.shell_tzresult o)) * (H * a * b * q * i * o)) *
        (((RPC_service.t
          ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
            (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
          (((RPC_context.t * a) * b) * c) q i o -> a -> a -> b -> c -> q -> i ->
        Lwt.t (Error_monad.shell_tzresult o)) * (J * a * b * c * q * i * o)) * K))))
    * K * a -> a ->
  Lwt.t
    (Error_monad.shell_tzresult
      (list ((|Signature.Public_key_hash|).(S.SPublic_key_hash.t) * int32))).

Parameter proposals : forall {E F H J K a b c i o q : Set},
  (((RPC_service.t
    ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit +
      (* `PATCH *) unit) RPC_context.t RPC_context.t q i o -> a -> q -> i ->
  Lwt.t (Error_monad.shell_tzresult o)) * (E * q * i * o)) *
    (((RPC_service.t
      ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit
        + (* `PATCH *) unit) RPC_context.t (RPC_context.t * a) q i o -> a ->
    a -> q -> i -> Lwt.t (Error_monad.shell_tzresult o)) * (F * a * q * i * o))
      *
      (((RPC_service.t
        ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
          (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
        ((RPC_context.t * a) * b) q i o -> a -> a -> b -> q -> i ->
      Lwt.t (Error_monad.shell_tzresult o)) * (H * a * b * q * i * o)) *
        (((RPC_service.t
          ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
            (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
          (((RPC_context.t * a) * b) * c) q i o -> a -> a -> b -> c -> q -> i ->
        Lwt.t (Error_monad.shell_tzresult o)) * (J * a * b * c * q * i * o)) * K))))
    * K * a -> a ->
  Lwt.t
    (Error_monad.shell_tzresult
      ((|Protocol_hash|).(S.HASH.Map).(S.INDEXES_Map.t) Int32.t)).

Parameter current_proposal : forall {E F H J K a b c i o q : Set},
  (((RPC_service.t
    ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit +
      (* `PATCH *) unit) RPC_context.t RPC_context.t q i o -> a -> q -> i ->
  Lwt.t (Error_monad.shell_tzresult o)) * (E * q * i * o)) *
    (((RPC_service.t
      ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit + (* `POST *) unit
        + (* `PATCH *) unit) RPC_context.t (RPC_context.t * a) q i o -> a ->
    a -> q -> i -> Lwt.t (Error_monad.shell_tzresult o)) * (F * a * q * i * o))
      *
      (((RPC_service.t
        ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
          (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
        ((RPC_context.t * a) * b) q i o -> a -> a -> b -> q -> i ->
      Lwt.t (Error_monad.shell_tzresult o)) * (H * a * b * q * i * o)) *
        (((RPC_service.t
          ((* `PUT *) unit + (* `GET *) unit + (* `DELETE *) unit +
            (* `POST *) unit + (* `PATCH *) unit) RPC_context.t
          (((RPC_context.t * a) * b) * c) q i o -> a -> a -> b -> c -> q -> i ->
        Lwt.t (Error_monad.shell_tzresult o)) * (J * a * b * c * q * i * o)) * K))))
    * K * a -> a ->
  Lwt.t (Error_monad.shell_tzresult (option (|Protocol_hash|).(S.HASH.t))).

Parameter register : unit -> unit.