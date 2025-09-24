import 'package:e_commerce_flutter/core/utils/navigator.dart';
import 'package:e_commerce_flutter/features/onboarding/views/home_screen.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/custom.dart';
import '../../../core/utils/custom2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Manager/Register_cubit/register_cubit.dart';
import '../Manager/Register_cubit/register_state.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.only(left: 26.0, right: 26),
              child: SingleChildScrollView(
                child: Form(
                  key: RegisterCubit.get(context).formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create an\naccount',
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Customformfeild(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'Name must contain letters only';
                          }
                          return null;
                        },
                        controller: RegisterCubit.get(context).nameController,
                        prefixIcon: const Icon(Icons.person),
                        hintText: 'Full Name',
                      ),
                      Customformfeild(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Phone must contain numbers only';
                          }
                          if (value.length < 10 || value.length > 15) {
                            return 'Phone number must be between 10 and 15 digits';
                          }
                          return null;
                        },
                        controller: RegisterCubit.get(context).phoneController,
                        prefixIcon: const Icon(Icons.phone),
                        hintText: 'Phone',
                      ),
                      Customformfeild(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                              .hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                        controller: RegisterCubit.get(context).emailController,
                        prefixIcon: const Icon(Icons.email_rounded),
                        hintText: 'Email',
                      ),
                      Customformfeild(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                        controller:
                            RegisterCubit.get(context).passwordController,
                        visiable: RegisterCubit.get(context).passIsVisiable,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              RegisterCubit.get(context).changePassVisibility(),
                          icon: Icon(RegisterCubit.get(context).passIsVisiable
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        hintText: 'Password',
                      ),
                      Customformfeild(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value !=
                              RegisterCubit.get(context)
                                  .passwordController
                                  .text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        controller: RegisterCubit.get(context)
                            .confirmPasswordController,
                        visiable: RegisterCubit.get(context).confPassVisiable,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              RegisterCubit.get(context).changConfPassVisi(),
                          icon: Icon(RegisterCubit.get(context).confPassVisiable
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        hintText: 'Confirm Password',
                      ),
                      const Text(
                        'By clicking the Register button, you agree\nto the public offer',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocConsumer<RegisterCubit, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterSuccessState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Register Successfully'),
                              ),
                            );
                          }
                          if (state is RegisterErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is RegisterLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return CustomElvButt(
                              onPressed: () {
                                if (RegisterCubit.get(context)
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  RegisterCubit.get(context)
                                      .onRegister(context);
                                  MyNavigator.goTo(
                                      context: context, screen: HomeScreen());
                                }
                              },
                              text: "Create Account",
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
