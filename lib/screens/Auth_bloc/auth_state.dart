part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginInitial extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginLoading extends AuthState {}

// ignore: must_be_immutable
final class LoginFailure extends AuthState {
  String errorMassege;
  LoginFailure({required this.errorMassege});
}

final class RegisterInitial extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

// ignore: must_be_immutable
final class RegisterFailure extends AuthState {
  // ignore: non_constant_identifier_names
  String ErrorMassege;
  // ignore: non_constant_identifier_names
  RegisterFailure({required this.ErrorMassege});
}
