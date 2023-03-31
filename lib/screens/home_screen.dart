import 'package:flutter/material.dart';
import 'package:project_purify/providers/child_profile.dart';
import 'package:project_purify/screens/child_profile_screen.dart';
import 'package:project_purify/screens/milestone_screen.dart';
import 'package:project_purify/screens/tracker_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedNavBarIndex = 0;

  Widget buildChildInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(255, 25, 204, 168),
      ),
      child: Column(
        children: [
          Text(
            "${context.watch<ChildProfileProvider>().getCurrentProfile()!
                .getName()} is ${context.watch<ChildProfileProvider>()
                .getCurrentProfile()!.getAge()
                .toString()} months!",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 184, 239, 228),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Weight",
                        style: TextStyle(
                          color: Color.fromARGB(255, 33, 82, 96),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Text(
                        "${context.watch<ChildProfileProvider>()
                            .getCurrentProfile()!
                            .getWeight()} kg",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 25, 62, 72),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromARGB(255, 184, 239, 228),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Height",
                        style: TextStyle(
                          color: Color.fromARGB(255, 33, 82, 96),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Text(
                        "${context.watch<ChildProfileProvider>()
                            .getCurrentProfile()!
                            .getHeight()} cm",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 25, 62, 72),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    Widget buildProfileList() {
      int profileIndexer = 0;
      List<Widget> profileButtons = [];
      List<ChildProfile> childProfiles = context.read<ChildProfileProvider>().getProfiles()!;
      for (int i = 0; i < childProfiles.length; i++){
        profileButtons.add(
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {
                int thisIndex = i;
                context.read<ChildProfileProvider>().changeChildProfile(to: thisIndex);
                Navigator.of(context).pop();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    childProfiles[i].getName(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${childProfiles[i].getAge()} mo",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 186, 201, 206)
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
            )
        );
      }
      return Container(
        height: 172,
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 128,
              child: Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                child: ListView(
                  controller: scrollController,
                  children: profileButtons,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChildProfileCreationScreen()
                    )
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: const [
                    Icon(Icons.add, size: 28, color: Colors.black,),
                    Text(
                      "Add Child Profile",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    List<Function> actions = [
          () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));
      },
          () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TrackerScreen();
        }));
      },
          () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MilestoneScreen();
        }));
      },
    ];

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return AlertDialog(
                        content: buildProfileList(),
                      );
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          context.watch<ChildProfileProvider>()
                              .getCurrentProfile()!
                              .getName(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              buildChildInfo(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MilestoneScreen()
                      )
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${context.watch<ChildProfileProvider>()
                              .getCurrentProfile()!
                              .getName()}'s Milestone",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.navigate_next,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 36,),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.soup_kitchen, size: 36,),
            label: "Tracker",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded, size: 36,),
            label: "Milestone",
          ),
        ],
        currentIndex: _selectedNavBarIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 83, 98),
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            _selectedNavBarIndex = index;
            actions[index]();
          });
        },
      ),
    );
  }

  Widget BuildProfileContainer() {
    ChildProfile? profile = context.watch<ChildProfileProvider>()
        .getCurrentProfile();
    if (profile != null) {
      return Column(
        children: [
          Text(
              "Nama: ${profile.getName()}"
          ),
          Text(
              "Age: ${profile.getAge().toString()}"
          ),
          Text(
              "Weight: ${profile.getWeight().toString()}"
          ),
          Text(
              "Height: ${profile.getHeight().toString()}"
          ),
          Text(
              "Sex: ${profile.getSex().toString()}"
          )
        ],
      );
    }
    else {
      return Container(
        child: Text('No profile'),
      );
    }
  }
}