import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        titleSpacing: 20.0,
        elevation: 0.0,
        backgroundColor: Colors.black87,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                "https://esossl-a.akamaihd.net/assets/img/crownstore/items/95707f7a7e4b504ed13a44bdc063e85b.jpg"
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "Chats",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[800],
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          CircleAvatar(
            backgroundColor: Colors.grey[800],
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],

      ),
      body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[850],
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.grey,

                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height:100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder:(context , index) => Story(),
                    separatorBuilder: (context , index) => SizedBox(
                      width: 20,
                    ),
                    itemCount: 10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (Context , index) => Chat(),
                  separatorBuilder: (Context , index) => SizedBox(
                    height: 20,
                  ),
                  itemCount: 10),
            )
          ],
        ),
      ),

    );
  }
}


Widget Story() => Container(
  width: 60,
  child: Column(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                "https://esossl-a.akamaihd.net/assets/img/crownstore/items/95707f7a7e4b504ed13a44bdc063e85b.jpg"
            ),
          ),
          CircleAvatar(
            radius: 9,
            backgroundColor: Colors.black87,
          ),
          CircleAvatar(
            radius: 7,
            backgroundColor: Colors.red,
          ),
        ],
      ),
      SizedBox(
        height: 7,
      ),
      Text(
        "NegroMancer the realist nigga",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
        ),
      )
    ],
  ),
);
Widget Chat() => Row(
  children: [
    Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
              "https://esossl-a.akamaihd.net/assets/img/crownstore/items/95707f7a7e4b504ed13a44bdc063e85b.jpg"
          ),
        ),
        CircleAvatar(
          radius: 9,
          backgroundColor: Colors.black87,
        ),
        CircleAvatar(
          radius: 7,
          backgroundColor: Colors.red,
        ),
      ],
    ),
    SizedBox(
      width: 15,
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "NegroMancer",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "U ALL WILL DIE AND ONLY ME WILL REMAIN AND IM ON ALL YO MAMAS",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  height: 7,
                  width: 7,
                ),
              ),
              Text(
                "10:48",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    )
  ],
);