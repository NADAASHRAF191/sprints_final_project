import 'login_state.dart';
import 'package:flutter/material.dart';
import '../../data/Reop/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserRepo userRepo = UserRepo();
  bool passIsVisiable = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void changePassVisibility() {
    passIsVisiable = !passIsVisiable;
    emit(LoginChangeVisibilityState(passIsVisiable));
  }

  void onLogin(BuildContext context) {
    emit(LoginLoadingState());

    // Simulate login process
    Future.delayed(const Duration(seconds: 2), () {
      final email = emailController.text;
      final password = passwordController.text;

      if (email == "test@test.com" && password == "123456") {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState("Log in successfully"));
      }
    });
  }
}
