import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/shared/components.dart';
import 'package:e_commerce/states/shope_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubites/shope_cubit.dart';
import '../../styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  late String name, phone, email;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopeCubit, ShopeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopeCubit.get(context).userModel!;
        name = model.data!.name!;
        phone = model.data!.phone!;
        email = model.data!.email!;

        return ConditionalBuilder(
          condition: ShopeCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.person,
                        size: 50.0,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  height: 60.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 50.0,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        phone,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  height: 60.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.email,
                        size: 50.0,
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                MaterialButton(
                  onPressed: () {
                    signOut(context);
                  },
                  height: 45.0,
                  minWidth: double.infinity,
                  color: defaultColors,
                  child: const Text(
                    'Log Ouut',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
