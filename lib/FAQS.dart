import 'package:flutter/material.dart';

class FAQS extends StatefulWidget {
  const FAQS({super.key});

  @override
  State<FAQS> createState() => _FAQSState();
}

class _FAQSState extends State<FAQS> {
  Icon DownIcons = Icon(Icons.arrow_circle_down);
  Icon UpIcon = Icon(Icons.arrow_circle_up);
  var isExpanded = false;

  final List FAQSList = const [
    {
      "Question": "How do i play?",
      "Answer":
          "To play the game, start by downloading and installing it from your device’s app store or the game’s official website. Once installed, open the game and create an account or log in if you already have one. Follow the tutorial if available, as it will guide you through the basic controls and gameplay mechanics. Familiarize yourself with the game’s objectives, such as completing missions, participating in events, or achieving specific goals. Use the on-screen controls to navigate, interact, and perform actions within the game. Regularly check for updates, events, and rewards to enhance your gaming experience. If you encounter any issues or need further guidance, refer to the game’s help section or community forums for tips and support."
    },
    {
      "Question": "What's in the map?",
      "Answer":
          "The map in the game is a crucial feature that helps players navigate the game world and locate important points of interest. It typically includes various markers indicating the locations of missions, events, resources, and other interactive elements. Players can use the map to plan their routes, find objectives, and explore different areas. Some maps offer features like zooming in and out, setting waypoints, and displaying real-time updates on events or enemy positions. Understanding the map is essential for efficient gameplay, as it provides a comprehensive overview of the game environment and helps players strategize their actions and movements."
    },
    {
      "Question": "Is it free to play?",
      "Answer":
          "Whether a game is free to play depends on its specific model. Many games offer a free-to-play (F2P) option where players can download and play the game at no initial cost. However, these games often include optional in-game purchases, such as virtual currency, cosmetics, or additional content, which players can choose to buy to enhance their gaming experience or progress faster. The availability and extent of these microtransactions vary by game. Some free-to-play games may also offer premium subscriptions or memberships that provide exclusive benefits or content. Overall, while the base game itself may be free, players can decide whether or not to spend money on optional items or features within the game."
    },
    {
      "Question": "How do i get Dice Rolls?",
      "Answer":
          "In many games that involve dice rolls, such as board games or digital adaptations, obtaining dice rolls typically depends on specific game mechanics. Normally, players earn dice rolls through various actions or achievements within the game. This might include completing missions or quests, reaching certain milestones or levels, participating in events, or sometimes through daily log-in rewards. In some games, players might also be able to acquire dice rolls through in-game purchases using virtual currency or real money. The number of dice rolls you have is usually displayed prominently on the game interface, allowing you to track and use them strategically as you progress through the game. Understanding how dice rolls are earned and utilizing them effectively can often be key to achieving success in these games."
    },
    {
      "Question": "How do i get Shields?",
      "Answer":
          "In many games, shields are a protective mechanism that can help safeguard your progress or resources from attacks or other forms of harm. The acquisition of shields typically depends on the game's mechanics and objectives. Generally, shields can be obtained through various in-game activities such as completing quests, participating in events, achieving certain milestones, or by purchasing them with in-game currency or real money. Some games also offer shields as rewards for logging in daily or as part of promotional offers. Shields are often displayed as a resource or item in your inventory or game interface, where you can activate them when needed to protect against potential threats or setbacks. Understanding how shields are acquired and used effectively can enhance your gameplay experience by providing an added layer of defense and security."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffde4b4),
      appBar: AppBar(
        title: Text(
          "FAQS",
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: FAQSList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 5, left: 15, right: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black,
                              blurRadius: 3,
                            ),
                          ],
                          color: Color(0xfffbbf50),
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Color(0xff966303), width: 3)),
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
                              "${FAQSList[index]['Question']}",
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
                                    "${FAQSList[index]['Answer']}",
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
