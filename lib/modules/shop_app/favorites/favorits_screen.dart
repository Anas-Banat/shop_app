import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class FavoritsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context,state){}, 
      builder : (context,state){
        return ListView.separated(
          itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).favoritesModel.data.),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: 10,
        );
      },
    );
  }


  Widget buildFavItem() => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(image: NetworkImage(model.image),
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
                ),
                if(model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
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
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.4,
                    ),
                  ),
    
                  Spacer()
            
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
            
                      SizedBox(
                        width: 5.0,
                      ),
            
                      if(model.discount != 0)
                        Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
            
                      Spacer(),
                      
                      IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id);
                        }, 
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.get(context).favorites[model.id] ? defaultColor : Colors.grey,
                          child: Icon(
                            Icons.favorite,
                            size: 14.0,
                            color: Colors.white,
                            ),
                          ),
                      ),
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