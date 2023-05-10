import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  String text,
  bool isUpperCase = true,
  double radius = 0.0,
  // Used VoidCallback to call the functoin
  GestureTapCallback function,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );




Widget defaultTextButton({
  Function function,
  String text,
}) => TextButton(
                  onPressed: function, 
                  child: Text(
                    text.toUpperCase(),
                  ),
                );




Widget defaultFormField({
   TextEditingController controller,
   TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  Function validate,
  String lable,
  bool isPassword = false,
  bool isClickable = true,
  IconData prefix,
  IconData suffix,
  Function() suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      onFieldSubmitted: (value) {
        onSubmit(value);
      },
      onChanged: (value) {
        onChange(value);
      },
      onTap: () {
        onTap();
      },
      validator: (value) {
        validate(value);
      },
      enabled: isClickable,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: lable,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                ),
                onPressed: () {
                  suffixPressed();
                },
              )
            : null,
      ),
    );




Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );



void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);




void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
  builder: (context) => Widget,),
  (Route<dynamic> route) => false);

  void showToast({
    String text,
    ToastStates state
  }) => Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
  );

enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}



Widget buildListProduct(model, context, {bool isOldPrice = true,}) => Padding(
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
                ),
                if(model.discount != 0 && isOldPrice)
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
    
                  Spacer(),
            
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                            
                      SizedBox(
                        width: 5.0,
                      ),
                            
                      if(model.discount != 0 && isOldPrice)
                        Text(
                        model.oldPrice.toString(),
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