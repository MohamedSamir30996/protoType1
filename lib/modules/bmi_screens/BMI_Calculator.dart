import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:udemy_start/modules/bmi_screens/BMI_Results.dart';


class BMICalculator extends StatefulWidget {

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {

  bool isMale = true;
  double height = 180;
  int weight = 60 ;
  int age = 28 ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "BMI Calculator",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap:(){
                        setState(() {
                          isMale = true;
                        });
                      },
                      child:
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isMale ? Colors.indigo : Colors.grey,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image:
                            AssetImage(
                              'Assets/Images/Male.png',
                            ),
                              height: 90,
                              width: 90,
                            ),
                            Text(
                              "Male",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale = false ;
                        });
                      },
                      child:
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: !isMale ? Colors.indigo : Colors.grey,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(image:
                            AssetImage(
                              'Assets/Images/Female.png',
                            ),
                              height: 90,
                              width: 90,
                            ),
                            Text(
                              "Female",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "HEIGHT",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          "${height.round()}",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 45,
                          ),
                        ),
                        Text(
                          "Cm",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Slider(value: height,
                        min: 150,
                        max: 220,
                        onChanged: (value){
                      setState(() {
                        height = value ;
                      });
                        },

                    )
                  ],
                ),
              ),

            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Weight",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "${weight}",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),

                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(

                                  onPressed: () {
                                    setState(() {
                                      weight--;
                                    });
                              },
                                heroTag: 'w-',
                                mini: true,
                                child: Icon(
                                  Icons.remove,
                                ),
                              ),
                              FloatingActionButton(

                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                                heroTag: 'w+',
                                mini: true,
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Age",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "${age}",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),

                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(

                                onPressed: () {
                                  setState(() {
                                    age--;
                                  });
                                },
                                heroTag: 'a-',
                                mini: true,
                                child: Icon(
                                  Icons.remove,
                                ),
                              ),
                              FloatingActionButton(

                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                                heroTag: 'a+',
                                mini: true,
                                child: Icon(
                                  Icons.add,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child:
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              width: double.infinity,
              child: TextButton(onPressed: (){
                  double result = weight / pow(height / 100, 2);
                  print(result.round());

                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => BMIResult(
                            age: age,
                            isMale: isMale,
                            result: result.round(),
                          )
                      ),
                  );
              },
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}
