import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent ,
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          "First Nigga",
        ),
        centerTitle: true,
        actions: [
          IconButton(
             icon: Icon(
              Icons.notifications,
            ),
            onPressed: (){
               print("HELLO");
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: (){
              print("OOOOOAAAA");
            },
          ),
        ],
      ),
      //wrap to SafeArea if there isn't AppBar here
       body: Column(
         children: [
           Padding(
             padding: const EdgeInsets.all(85.0),
             child:
             Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
               ),
               clipBehavior: Clip.antiAliasWithSaveLayer,
               width: 250,
               child: Stack(
                 alignment: AlignmentDirectional.topCenter,
                 children: [
                   Image(

                    image: NetworkImage(
                      "https://m.media-amazon.com/images/I/919bzqfehrL._SS500_.jpg",
                    ),
                     height: 300,
                     width: 250,
                     fit: BoxFit.cover,
                   ),
                   Container(
                     padding: EdgeInsets.symmetric(
                       vertical: 7,
                       horizontal: 1,
                     ),
                     width: double.infinity,
                     color: Colors.grey.withOpacity(.3),
                     child: Text(
                       "FOR THE HOMMIES !",
                       textAlign: TextAlign.center,
                       style: TextStyle(
                         fontSize: 17,
                         color: Colors.white70.withOpacity(.4),
                       ),
                     ),
                   )
                 ],
               ),
             ),
           ),
         ],
       )
    );
  }
  
}