import 'package:e_commerce/cubites/shope_cubit.dart';
import 'package:e_commerce/cubites/search_cubit.dart';
import 'package:e_commerce/states/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70.0,
                      width: double.infinity,
                      child: TextFormField(
                        cursorColor: defaultColors,
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'search must not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Search'),
                          labelStyle: const TextStyle(color: defaultColors),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: defaultColors),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: defaultColors),
                          ),
                          prefix: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildSearchItem(
                                SearchCubit.get(context)
                                    .model!
                                    .data!
                                    .data![index],
                                context),
                            separatorBuilder: (context, index) => Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data!
                                .data!
                                .length),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                      model.image!,
                    ),
                    width: 120.0,
                    height: 120.0,
                  ),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.price}',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: defaultColors,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopeCubit.get(context)
                                  .changeFavorites(model.id!);
                            },
                            icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor:
                                  ShopeCubit.get(context).favorits[model.id]!
                                      ? defaultColors
                                      : Colors.grey,
                              child: const Icon(
                                Icons.favorite_border,
                                size: 12.0,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
