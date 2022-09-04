import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/home/home_states.dart';
import 'package:e_commerce/models/favorites_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/home_cubit.dart';
import '../styles/colors.dart';

class FavoritsScreen extends StatelessWidget {
  const FavoritsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopeCubit,ShopeStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! ShopeLoadingGetFavoritesState,
          builder:(context)=> ListView.separated(
              itemBuilder: (context,index)=>buildFavItem(ShopeCubit.get(context).favoritesModel!.data!.data![index],context),
              separatorBuilder: (context,index)=>Container(height: 1,color: Colors.grey,),
              itemCount: ShopeCubit.get(context).favoritesModel!.data!.data!.length) ,
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,

        );
      },

    );
  }
  Widget buildFavItem(FavoritesData model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(

        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  model.product!.image!,
                ),

                width: 120.0,
                height: 120.0,
              ),
              if (model.product!.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product!.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.product!.price.round()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColors,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.product!.discount != 0)
                      Text(
                        '${model.product!.oldPrice.round()}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(

                        onPressed: () {
                          ShopeCubit.get(context).changeFavorites(model.product!.id!);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:ShopeCubit.get(context).favorits[model.product!.id]! ? defaultColors : Colors.grey,
                          child: Icon(
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
