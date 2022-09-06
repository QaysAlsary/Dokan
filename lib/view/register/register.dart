import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:e_commerce/cubites/register_cubit.dart';
import 'package:e_commerce/states/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cache_helper.dart';
import '../../shared/components.dart';
import '../../shared/constants.dart';
import '../../styles/colors.dart';
import '../home/shope_layout.dart';
import '../login/login.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessStates) {
            if (state.registerModel.status == true) {
              CacheHelper.saveData(
                      key: 'token', value: state.registerModel.data!.token)
                  .then((value) {
                token = state.registerModel.data!.token;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const ShopeLayout()),
                  (Route<dynamic> route) => false,
                );
              });
            } else {
              showToast(
                  text: state.registerModel.message.toString(),
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'Register now to browse our hot offers',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          height: 70.0,
                          width: double.infinity,
                          child: TextFormField(
                            cursorColor: defaultColors,
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'name must not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('User Name'),
                              labelStyle: const TextStyle(color: defaultColors),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: defaultColors),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: defaultColors),
                              ),
                              prefix: const Icon(Icons.person_outline),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          height: 70.0,
                          width: double.infinity,
                          child: TextFormField(
                            cursorColor: defaultColors,
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'phone number must not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Phone Number'),
                              labelStyle: const TextStyle(color: defaultColors),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: defaultColors),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: defaultColors),
                              ),
                              prefix: const Icon(Icons.phone_outlined),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          height: 70.0,
                          width: double.infinity,
                          child: TextFormField(
                            cursorColor: defaultColors,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'email must not be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Email Address'),
                              labelStyle: const TextStyle(color: defaultColors),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: defaultColors),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: defaultColors),
                              ),
                              prefix: const Icon(Icons.email_outlined),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          height: 70.0,
                          width: double.infinity,
                          child: TextFormField(
                            cursorColor: defaultColors,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            // onFieldSubmitted: (value) {
                            //   if (formKey.currentState!.validate()) {
                            //     RegisterCubit.get(context).userRegister(
                            //         email: emailController.text,
                            //         password: passwordController.text);
                            //   }
                            // },
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                              return null;
                            },
                            obscureText: RegisterCubit.get(context).isPassword,
                            decoration: InputDecoration(
                              suffix: IconButton(
                                icon: Icon(RegisterCubit.get(context).suffix),
                                onPressed: () {
                                  RegisterCubit.get(context)
                                      .changePasswordVisibility();
                                },
                              ),
                              label: const Text('Password'),
                              labelStyle: const TextStyle(color: defaultColors),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: defaultColors),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide:
                                    const BorderSide(color: defaultColors),
                              ),
                              prefix: const Icon(Icons.lock_outline),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingStates,
                          builder: (context) => MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            height: 45.0,
                            minWidth: double.infinity,
                            color: defaultColors,
                            child: const Text('Register'),
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'already have an account? ',
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                child: Text('Login now'.toUpperCase()))
                          ],
                        )
                      ],
                    ),
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
