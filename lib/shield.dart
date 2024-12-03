import 'dart:convert';

import 'package:diceapp/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'globals.dart' as globals;

class Shield extends StatefulWidget {
  const Shield({super.key});

  @override
  State<Shield> createState() => _ShieldState();
}

class _ShieldState extends State<Shield> {
  List<Map<String, dynamic>> shieldData = [];
  Set<int> unlockedShield = {};
  final box = GetStorage();

  Future<void> loadShield() async {
    var response = await rootBundle.loadString("Asserts/Files/shield.json");
    Map<String, dynamic> result = json.decode(response);

    setState(() {
      shieldData = List<Map<String, dynamic>>.from(result['shield_data']);
      unlockedShield = (box.read('unlockedShields') ?? []).toSet().cast<int>();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadShield();
  }

  void unlockShield(int index) {
    if (Globals.globalToken > 0) {
      setState(() {
        unlockedShield.add(index);
        box.write('unlockedShields', unlockedShield.toList());
        Globals.globalToken -= 25;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("25 Token Use")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Insufficient Token")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffde4b4),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Shield"),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Asserts/dice.png"))),
                    ),
                    Text('${Globals.globalToken}'),
                  ],
                ),
              ),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: shieldData.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(3.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 2),
            itemCount: shieldData.length,
            itemBuilder: (context, index) {
              var name = shieldData[index]['name'] ?? 'Unknown';
              var description = shieldData[index]['description'] ??
                  'No description available';
              var image =
              shieldData[index]['image'];
              var unlocked = unlockedShield.contains(index);

              return GestureDetector(
                onTap: () {
                  if (unlocked) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xfffde4b4),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff966303),
                                  blurRadius: 3,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xff966303), // Border color
                                width: 4, // Border width
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      border: BorderDirectional(
                                          bottom: BorderSide(
                                              color: Color(0xff966303),
                                              width: 4))),
                                  child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      child: image != null ? Image.network(
                                        image,
                                        fit: BoxFit.cover,) :
                                      Image.asset(
                                        "Asserts/dice11.jpg", fit: BoxFit.cover,)
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Color(0xff966303),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        description,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          child: Text(
                                            "Done",
                                            style: TextStyle(
                                                letterSpacing: 3,
                                                fontSize: 20,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ButtonStyle(
                                              shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        15),
                                                  )),
                                              backgroundColor:
                                              WidgetStateProperty.all(
                                                  Color(0xfffbbf50))),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xfffde4b4),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xff966303), // Border color
                                width: 3, // Border width
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Are you sure?",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                      "Remove your 25 Dice to unlock this token."),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        child: Text(
                                          "No",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          unlockShield(index);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(10),
                                                    side: BorderSide(
                                                        color: Color(
                                                            0xff966303),
                                                        width: 2))),
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Color(0xfffbbf50))),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7, vertical: 5),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: image!=null ?DecorationImage(
                                  image: NetworkImage(image),
                                  fit: BoxFit.cover):
                          DecorationImage(image: AssetImage("Asserts/dice11.jpg"),fit: BoxFit.cover)),
                        ),
                        if (!unlocked)
                          Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "Asserts/lock.png"))),
                                    )),
                              ))
                      ],
                    )),
              );
            },
          ),
        ),
      ),
    );
  }
}
