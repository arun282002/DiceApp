import 'dart:convert';
import 'package:diceapp/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class RewardsDetails extends StatefulWidget {
  final Map<String, dynamic> rewardsData;
  final Map<String, dynamic> data;
  final globalINDEX;
  // int dateIndex = 0;
  // int linkIndex = 0;

  RewardsDetails(
      {Key? key,
      required this.rewardsData,
      required this.data, this.globalINDEX,
      // this.dateIndex = 0,
      // this.linkIndex = 0
      })
      : super(key: key);

  @override
  State<RewardsDetails> createState() => _RewardsDetailsState();
}

class _RewardsDetailsState extends State<RewardsDetails> {
  final storage = GetStorage();
  bool claimed=false;
  bool isloading=false;
  // var localList;
  // var temp;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    loadClaimedStatus();
    setState(() {
      isloading=true;
    });
  }

  void loadClaimedStatus() {
    String? storedClaimedStatus = storage.read('claimed');
    if (storedClaimedStatus != null) {
      List<dynamic> decodedStatus = jsonDecode(storedClaimedStatus);
      setState(() {
        isloading=false;
        claimed = decodedStatus.length > widget.globalINDEX && decodedStatus[widget.globalINDEX] == 'true';
      });
    }
  }

  void _claimToken() {
    if (!claimed) {
      setState(() {
        claimed = true;
        Globals.globalToken += 25;
        launchUrl(Uri.parse(widget.data['link']));
        saveClaimedStatus();
        // widget.onClaim(widget.globalIndex); // Call the callback function
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("You have claimed 25 tokens!"),
        ));// Return to the first screen
      });
    } else {
      launchUrl(Uri.parse(widget.data['link']));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Tokens have already been claimed!"),
      ));
    }
  }

  void saveClaimedStatus() {
    List<dynamic> claimedStatus = jsonDecode(storage.read('claimed') ?? '[]');
    if (claimedStatus.length <= widget.globalINDEX) {
      claimedStatus.length = widget.globalINDEX + 1;
    }
    claimedStatus[widget.globalINDEX] = 'true';
    storage.write('claimed', jsonEncode(claimedStatus));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffde4b4),
      appBar: AppBar(
        title: Text("Claim Your Dice"),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:isloading?Center(child: CircularProgressIndicator(),): Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Asserts/dice1.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                widget.rewardsData['date'].toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Color(0xff966303),
                  letterSpacing: 5,
                ),
              ),
              Text(
                widget.data['name'].toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {

                    _claimToken();


                    // localList[widget.dateIndex][widget.linkIndex] = true;
                    // temp = storage.write("localList", localList.toString());
                    // print(
                    //     "rewars local list ${localList.toString()}"); // launchUrl(Uri.parse(widget.data['links']));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                        ),
                      ],
                      color: Color(0xfffbbf50),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color(0xff966303),
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Claim",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async{
                      final uri = (widget.data['link']).toString();
                      await Clipboard.setData(ClipboardData(text: uri));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("successfully copied")));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width:150,
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black,
                              blurRadius: 3,
                            ),
                          ],
                          color: Color(0xff966303),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Copy",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var uri = (widget.data['link']).toString();
                      final result = await Share.share(uri);
                      // if (result.status == ShareResultStatus.success) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text("Success")),
                      //   );
                      // }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black,
                              blurRadius: 3,
                            ),
                          ],
                          color: Color(0xff966303),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Share",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Note: Claim fast and share with your friends",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
