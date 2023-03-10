import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

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