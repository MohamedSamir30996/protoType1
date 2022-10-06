import 'package:flutter/material.dart';
import 'package:udemy_start/models/users/user_model.dart';


class UserScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    List<UsersDatabase> User = [
      UsersDatabase(1,
          "Samir",
          "+2001056871029",),
      UsersDatabase(2,
        "Omar",
        "+2001088871029",),
      UsersDatabase(1,
        "Toba",
        "+2001056871309",),
      UsersDatabase(1,
        "Samir",
        "+2001056871029",),
      UsersDatabase(2,
        "Omar",
        "+2001088871029",),
      UsersDatabase(1,
        "Toba",
        "+2001056871309",),
      UsersDatabase(1,
        "Samir",
        "+2001056871029",),
      UsersDatabase(2,
        "Omar",
        "+2001088871029",),
      UsersDatabase(1,
        "Toba",
        "+2001056871309",),
    ];



    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Users"
        ),
      ),
      body:
        ListView.separated(itemBuilder: (context,index) => UsersBuild(User[index]),
            separatorBuilder: (context,index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[400],
              ),
            ),
            itemCount: User.length)
    );
  }
}

Widget UsersBuild (UsersDatabase x) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 30,
        child: Text(
          '${x.ID}',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        width: 15,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${x.Name}",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${x.Phone}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      )
    ],
  ),
);