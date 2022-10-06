import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_start/layout/ShopApp/Cubit/Cubit.dart';
import 'package:udemy_start/layout/TodoApp/Cubit/Cubit.dart';
import 'package:udemy_start/modules/news_screens/WebView_Screen.dart';
import 'package:udemy_start/shared/Cubit/cubit.dart';
import 'package:udemy_start/shared/styles/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget DefaultButton({
  double width = double.infinity,
  Color backgroundcolor = Colors.blue,
  required Function function,
  required String text,
  bool isUppercase = true,
  double radius = 0.0,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundcolor,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function as void Function()?,
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget DefaultFormField({
  required TextEditingController controller,
  required TextInputType textType,
  bool isPassword = false,
  Function? onChange,
  Function? onFieldSubmitted,
  required String lable,
  required IconData prefix,
  IconData? suffix,
  required Function valid,
  Function? suffixChange,
  Function? OnTap,
  bool isenabled = true,
  bool showCursor = false,
  bool readOnly = false,

}) =>
    TextFormField(
      controller: controller,
      keyboardType: textType,
      enabled: isenabled,
      showCursor: showCursor,
      readOnly: readOnly,
      obscureText: isPassword,
      onFieldSubmitted: onFieldSubmitted as void Function(String)?,
      onChanged: onChange as void Function(String)?,
      onTap: OnTap as void Function()?,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
            icon: Icon(suffix),
          onPressed: suffixChange as void Function()?,
        ),
        border: OutlineInputBorder(),
      ),
      validator: valid as String? Function(String?)?,
    );


Widget BuildTaskItem(Map model,context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blue,
          child: Text(
            "${model['time']}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model['title']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text(
                "${model['date']}",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        IconButton(
            icon: Icon(
          Icons.check_box,
          color: Colors.green,
        ), onPressed: (){
              ToDoCubit.get(context).UpdateDataBase(status: 'done', id: model['id']);
        }),
        IconButton(
            icon: Icon(
              Icons.archive_rounded,
              color: Colors.black45,
            ), onPressed: (){
          ToDoCubit.get(context).UpdateDataBase(status: 'archive', id: model['id']);
        }),
      ],
    ),
  ),
  onDismissed: (direction) {
    ToDoCubit.get(context).DeleteDataBase(id: model['id']);
  },
);



Widget taskBuilder({
  required List<Map> tasks,
}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(itemBuilder: (context,index) => BuildTaskItem(tasks[index],context),
      separatorBuilder: (context,index) => MyDivider(),
      itemCount: tasks.length),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100,
        ),
        Text(
          "No Tasks yet .. Please add Tasks",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  ),
);





Widget BuildArticalItem(article,context) => InkWell(
  onTap: () {
    NavigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage("${article['urlToImage']}"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "${article['title']}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Text(
                  "${article['publishedAt']}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  ),
);

Widget MyDivider() => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Container(
    color: Colors.grey[400],
    height: 1,
    width: double.infinity,
  ),
);

Widget ArticleBuilder(list,context,{isSearch=false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index) => BuildArticalItem(list[index],context),
      separatorBuilder: (context,index) => MyDivider(),
      itemCount: list.length),
  fallback:(context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
);



void NavigateTo(context,widget) => Navigator.push(
      context,
  MaterialPageRoute(
      builder: (context) => widget,
  ),
);



void NavigateAndFinish(context,widget) => Navigator.pushAndRemoveUntil
  (
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic>route) => false,
);


void ShowToast({
  required String text ,
  required ToastStates state,
}) => Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: ChooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR,WARNING}

Color ChooseToastColor(ToastStates state)
{
  Color color ;

  switch(state){
    case ToastStates.SUCCESS :
    color = Colors.green;
    break;
    case ToastStates.ERROR :
      color = Colors.red;
      break;
    case ToastStates.WARNING :
      color = Colors.amber;
      break;
  }
  return color ;
}

Widget buildListProduct(
    model,
    context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
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
                      height: 1.3,
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
                      if (model.discount != 0 && isOldPrice)
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
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
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