import 'package:flutter/material.dart';

class Blog extends StatelessWidget {
  const Blog({super.key});

  final List QuestionList = const [
    {
      "Question": "My rewards is not showing up?",
      "Answer":
          "If your rewards are not showing up in a game, ensure you have a stable internet connection and that your game is updated. Check the game's official channels for server issues, and try restarting the game or your device. Log out and back into your account to sync properly. If the problem persists, contact the game's support with your game ID and details about the issue."
    },
    {
      "Question": "Tournaments",
      "Answer":
          "If your tournament rewards are not showing up in a game, ensure your internet connection is stable and that your game is updated to the latest version. Sometimes server issues or high traffic can cause delays, so check the game's official channels for any announcements. Restarting the game or your device can resolve minor glitches. Additionally, log out and back into your account to ensure proper synchronization. If the issue persists, contact the game's customer support with your game ID and details about the missing tournament rewards."
    },
    {
      "Question": "Daily Treats",
      "Answer":
          "If your daily treats or rewards are not showing up in a game, ensure that you have a stable internet connection and that your game is updated to the latest version. Sometimes, server issues or high traffic can delay reward delivery, so check the game's official channels for any announcements. Restarting the game or your device can help resolve minor glitches. Additionally, log out and back into your account to ensure proper synchronization. If the issue continues, contact the game's customer support with your game ID and details about the missing daily treats."
    },
    {
      "Question": "Community chest",
      "Answer":
          "If your community chest rewards are not showing up in a game, first ensure that you have a stable internet connection and that the game is updated to the latest version. Server issues or high traffic can sometimes cause delays, so check the game's official channels for any announcements. Restarting the game or your device can help resolve minor glitches. Additionally, log out and back into your account to ensure proper synchronization. If the problem persists, contact the game's customer support with your game ID and details about the missing community chest rewards."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffde4b4),
      appBar: AppBar(
        title: Text(
          "Blog",
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: QuestionList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 15, right: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [new BoxShadow(
                            color:  Colors.black,
                            blurRadius: 3,
                          ),],
                          color: Color(0xfffbbf50),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Color(0xff966303),
                              width: 3
                          )
                      ),


                      child: Theme(
                        data: ThemeData(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          dividerColor: Colors.transparent,
                          expansionTileTheme: const ExpansionTileThemeData(
                            backgroundColor: Colors.transparent,
                            collapsedBackgroundColor: Colors.transparent,
                          ),
                        ),
                        child: ExpansionTile(
                          iconColor: Colors.black,
                          collapsedIconColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          title: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 12),
                            child: Text(
                              "${QuestionList[index]['Question']}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 3,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${QuestionList[index]['Answer']}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
