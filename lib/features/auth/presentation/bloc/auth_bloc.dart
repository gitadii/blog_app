import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecases/usecase_interf.dart';
import 'package:blog_app/core/common/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogIn userLogIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    // When there is an event of AuthSignUp then do this :
    // on<AuthEvent>(_emitAuthLoading as EventHandler<AuthEvent, AuthState>);
    on<AuthEvent>((_, emit) => emit(
        AuthLoading())); // This will emit the Loading state whenever there is a state change
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogIn);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
  }

// FUCNTIONS TO MAKE CODE CLEAN
  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
// Until the signUp is complete the app should be in Loading state
    // emit(AuthLoading());

    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess,
    );
  }

  void _onAuthLogIn(
    AuthLogIn event,
    Emitter<AuthState> emit,
  ) async {
    // emit(AuthLoading());

    final res = await _userLogin(UserLoginParams(
      email: event.email,
      password: event.password,
    ));

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess,
    );
  }

  void _onAuthIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(
    UserEntity userEntity,
    Emitter<AuthState> emit,
  ) async {
    _appUserCubit.updateUser(userEntity);
    emit(AuthSucess(userEntity));
  }

  // void _emitAuthLoading(Emitter<AuthState> emit) {
  //   emit(AuthLoading());
  // }
}
