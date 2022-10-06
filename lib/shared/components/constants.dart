// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

import 'package:udemy_start/modules/shop_screens/Login_Screen/Shop_Login_Screen.dart';
import 'package:udemy_start/shared/components/components.dart';
import 'package:udemy_start/shared/network/local/Cache_Helper.dart';

void SignOut(context)
{
  CacheHelper.RmoveData(key: 'token').then((value) {
    NavigateAndFinish(
      context,
      ShopLoginScreen(),
    );
  });
}


void PrintFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';