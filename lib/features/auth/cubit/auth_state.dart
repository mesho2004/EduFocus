import 'package:equatable/equatable.dart';
import 'package:edufocus/features/auth/models/parent_model.dart';
import 'package:edufocus/features/auth/models/child_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Parent parent;
  final String token;
  final bool hasChild;

  const AuthSuccess({required this.parent, required this.token, this.hasChild = false});

  @override
  List<Object?> get props => [parent, token, hasChild];
}

class AuthFailure extends AuthState {
  final String errorMessage;

  const AuthFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class Unauthenticated extends AuthState {}

class ChildCreateLoading extends AuthState {}

class ChildCreateSuccess extends AuthState {
  final ChildModel child;

  const ChildCreateSuccess(this.child);

  @override
  List<Object?> get props => [child];
}

class ChildCreateFailure extends AuthState {
  final String errorMessage;

  const ChildCreateFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
