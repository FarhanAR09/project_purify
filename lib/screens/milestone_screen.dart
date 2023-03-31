import 'package:flutter/material.dart';
import 'package:project_purify/providers/child_profile.dart';
import 'package:project_purify/screens/tracker_screen.dart';
import 'package:project_purify/screens/video_screen.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class VideoInfo{
  //Picture thumbnail;
  String title;
  //int? duration;
  String id;
  String description;
  //List<Map<int,String>>? timestamps;

  //TODO: add picture field
  VideoInfo(this.title, this.description, this.id);
}

class MilestoneData{
  static List<List<VideoInfo>> videoInfos = [
    [
      VideoInfo("Yakuza OST - Baka Mitai", "Yakuza (Ryu ga Gotoku) 0, 5 and Kiwami karaoke, originally sang by Kiryu. Composition © Sega / Ryu ga Gotoku Studio", "g3jCAyPai2Y")
    ], //1
  ];

  static List<List<String>> movements = [
    [
      "Makes jerky, quivering arm thrusts",
      "Brings hands within range of eyes and mouth",
      "Moves head from side to side while lying on stomach",
      "Head flops backward if unsupported",
      "Keeps hands in tight fists",
      "Strong reflex movements",
    ], //1
    [
      "Holds head up when on tummy",
      "Moves both arms and both legs",
      "Opens hands briefly",
    ], //2
    [
      "Raises head and chest when lying on stomach",
      "Supports upper body with arms when lying on stomach",
      "Stretches legs out and kicks when lying on stomach or back",
      "Opens and shuts hands",
      "Pushes down on legs when feet are placed on a firm surface",
      "Brings hand to mouth",
      "Takes swipes at dangling objects with hands",
    ], //3
    [
      "Holds head steady without support when you are holding her",
      "Holds a toy when you put it in his hand",
      "Uses her arm to swing at toys",
      "Brings hands to mouth",
      "Pushes up onto elbows/forearms when on tummy",
    ], //4
    [
      "Can sit upright for longer periods of time",
      "Can start rolling over from their back to their tummy",
      "Baby’s grasp is getting stronger",
    ], //5
    [
      "Rolls from tummy to back",
      "Pushes up with straight arms when on tummy",
      "Leans on hands to support himself when sitting",
    ], //6
    [
      "Rolls both ways (front to back, back to front)",
      "Sits with, and then without, support of her hands",
      "Supports her whole weight on her legs",
      "Reaches with one hand",
      "Transfers object from hand to hand",
      "Uses raking grasp (not pincer)",
    ], //7
    [
      "Sit independently",
      "Start to stand while holding on to something (like the couch)",
      "Pull themselves up to a standing position",
    ], //8
    [
      "Gets to a sitting position by herself",
      "Moves things from one hand to her other hand",
      "Uses fingers to “rake” food towards himself",
      "Sits without support",
    ], //9
    [
      "Baby uses their index finger to point, push, touch, and explore",
      "Baby can pick up smaller and smaller objects by using their index finger and thumb like tongs, first with their forearm resting on the table, then without",
    ], //10
    [
      "Can intentionally let go of an object to give it to someone who asks for it",
      "Can put objects on the table",
      "Can imitate this gesture, for example clap your hands",
    ], //11
    [
      "Pulls up to stand",
      "Walks, holding on to furniture",
      "Drinks from a cup without a lid, as you hold it",
      "Picks things up between thumb and pointer finger, like small bits of food",
    ], //12
    [
      "Takes a few steps on his own",
      "Uses fingers to feed herself some food",
    ], //13 - 15
    [
      "Walks without holding on to anyone or anything",
      "Scribbles",
      "Drinks from a cup without a lid and may spill sometimes",
      "Feeds herself with her fingers",
      "Tries to use a spoon",
      "Climbs on and off a couch or chair without help",
    ], //16 - 18
    [
      "Can nest measuring cups and boxes inside one another",
      "Can remove certain items of clothing without help (e.g., hat, mitts, socks, unbuttoned coat)",
      "Can unwrap an object wrapped in paper",
      "Learning how to use simple tools, such as toy hammers",
      "Can stack up to five blocks",
      "Can drink from a cup by lifting it to their mouth and then setting it back on the table",
    ], //19 - 21
    [
      "Kicks a ball",
      "Runs",
      "Walks (not climbs) up a few stairs with or without help",
      "Eats with a spoon",
    ], //22 - 24
    [
      "Practice drawing by tracing lines",
      "Can build block towers that are seven blocks high or taller",
      "Can use scissors with both hands and cut with better control",
      "Can stack rings onto a peg",
    ], //25 - 27
    [
      "Uses hands to twist things, like turning doorknobs or unscrewing lids",
      "Takes some clothes off by himself, like loose pants or an open jacket",
      "Jumps off the ground with both feet",
      "Turns book pages, one at a time, when you read to her",
    ], //28 - 30
    [
      "Your child goes from gripping a pencil in their fist to holding it with the tips of their fingers",
      "Learning to draw dots, circles, and short lines",
      "Starting to cut paper with scissors, though not necessarily in a straight line",
      "Sometimes manage to turn the pages of a book",
      "Can turn knobs to open doors",
    ], //31 - 33
    [
      "Strings items together, like large beads or macaroni",
      "Puts on some clothes by himself, like loose pants or a jacket",
      "Uses a fork",
    ], //34 - 36
  ];
  static List<List<String>> cognitives = [
    [
      "Focuses 8 to 12 inches (20.3 to 30.4 cm) away",
      "Eyes wander and occasionally cross",
      "Prefers black-and-white or high-contrast patterns",
      "Prefers the human face to all other patterns",
    ], //1
    [
      "Watches you as you move",
      "Looks at a toy for several seconds",
    ], //2
    [
      "Watches faces intently",
      "Follows moving objects",
      "Recognizes familiar objects and people at a distance",
      "Starts using hands and eyes in coordination",
      "Smiles at the sound of your voice",
      "Begins to babble",
      "Begins to imitate some sounds",
      "Turns head toward direction of sound",
    ], //3
    [
      "If hungry, opens mouth when she sees breast or bottle",
      "Looks at his hands with interest",
    ], //4
    [
      "baby’s color perception has sharpened to the point can tell the difference between two shades of the same color",
    ], //5
    [
      "Puts things in her mouth to explore them",
      "Reaches to grab a toy he wants",
      "Closes lips to show she doesn’t want more food",
    ], //6
    [
      "Finds partially hidden object",
      "Explores with hands and mouth",
      "Struggles to get objects that are out of reach",
    ], //7
    [
      "love exploring new items",
      "start to develop an insistence for a favorite object",
    ], //8
    [
      "Looks for objects when dropped out of sight (like his spoon or toy)",
      "Bangs two things together",
    ], //9
    [
      "baby can look for a hidden object in several places, not just where they last saw it. For example, they may lift overturned bowls, look in a box, or open bags",
      "Can associate gestures and sounds with certain things. For example, your baby may meow at the cat, or point their finger in the air when they see a bird",
    ], //10
    [
      "baby’s memory is improving. For example, they are able to imitate a sound they heard earlier, and can remember an object that they’ve seen before, even if it’s no longer in front of them",
      "Your baby can stay focused on objects they like for several minutes at a time",
    ], //11
    [
      "Puts something in a container, like a block in a cup",
      "Looks for things he sees you hide, like a toy under a blanket",
    ], //12
    [
      "Tries to use things the right way, like a phone, cup, or book",
      "Stacks at least two small objects, like blocks",
    ], //13 - 15
    [
      "Copies you doing chores, like sweeping with a broom",
      "Plays with toys in a simple way, like pushing a toy car",
    ], //16 - 18
    [
      "Can recognize and name people they know in photographs",
      "Able to build a tower by stacking four or more toy blocks",
      "Can sort objects by colour or shape",
      "",
      "",
      "",
    ], //19 - 21
    [
      "Holds something in one hand while using the other hand; for example, holding a container and taking the lid off",
      "Tries to use switches, knobs, or buttons on a toy",
      "Plays with more than one toy at the same time, like putting toy food on a toy plate",
    ], //22 - 24
    [
      "Enjoy pretending and using objects in unusual ways, such as by grabbing a banana and pretending it’s a phone",
      "Have a better understanding of similarities and differences in shape and size, but may not be able to express them",
      "Learning to count",
      "Have a longer attention span and stay interested in activities for longer periods of time",
    ], //25 - 27
    [
      "Uses things to pretend, like feeding a block to a doll as if it were food",
      "Shows simple problem-solving skills, like standing on a small stool to reach something",
      "Follows two-step instructions like “Put the toy down and close the door.”",
      "Shows he knows at least one color, like pointing to a red crayon when you ask, “Which one is red?”",
    ], //28 - 30
    [
      "Can compare the size of different objects by using words like bigger or smaller",
      "They integrate known elements into their imagination and engage in role-playing games. E.g., pretending to be a cashier, parent, or teacher",
      "Have little control over their thoughts, words, or actions. For example, they interrupt adults or friends who are already speaking",
      "They associate similar images and objects, and sort different objects",
      "Enjoy taking in their surroundings and get inspired to make up movements, e.g., crawling around like a snake or tiptoeing across the room",
    ], //31 - 33
    [
      "Draws a circle, when you show him how",
      "Avoids touching hot objects, like a stove, when you warn her",
    ], //34 - 36
  ];
  static List<List<String>> communications = [
    [
      "Recognizes some sounds",
      "May turn toward familiar sounds and voices",
      "Hearing is fully mature",
    ], //1
    [
      "Makes sounds other than crying",
      "Reacts to loud sounds",
    ], //2
    [
      "Makes sounds other than crying",
      "Reacts to loud sounds",
    ], //3
    [
      "Makes sounds like “oooo”, “aahh” (cooing)",
      "Makes sounds back when you talk to him",
      "Turns head towards the sound of your voice",
    ], //4
    [
      "Starting to make sense of the sounds they hear",
      "Turn their head at the sound of their name or a simple command like ''no.''",
    ], //5
    [
      "Takes turns making sounds with you",
      "Blows “raspberries” (sticks tongue out and blows)",
      "Makes squealing noises",
    ], //6
    [
      "Responds to own name",
      "Begins to respond to “no”",
      "Distinguishes emotions by tone of voice",
      "Responds to sound by making sounds",
      "Uses voice to express joy and displeasure",
      "Babbles chains of consonants",
    ], //7
    [
      "Start to say “mamama,” or “dadadada,” and understand the word “no.”",
      "Gesture with their finger as part of a serious “conversation.”",
    ], //8
    [
      "Makes different sounds like “mamamama” and “babababa”",
      "Lifts arms up to be picked up",
    ], //9
    [
      "Understands when you approve or disapprove of their behaviour.",
      "Starting to develop autonomy and want to do things on their own, like get undressed",
      "Feel intense emotions and must learn to cope with them",
    ], //10
    [
      "Imitate adult behaviour and children’s gestures and games",
      "Enjoy being the centre of attention",
      "Repeat sounds or gestures that make you laugh",
      "Baby understands that they’re a separate individual",
    ], //11
    [
      "Waves “bye-bye”",
      "Calls a parent “mama” or “dada” or another special name",
      "Understands “no” (pauses briefly or stops when you say it)",
    ], //12
    [
      "Tries to say one or two words besides “mama” or “dada,” like “ba” for ball or “da” for dog",
      "Looks at a familiar object when you name it",
      "Follows directions given with both a gesture and words. For example, he gives you a toy when you hold out your hand and say, “Give me the toy.”",
      "Points to ask for something or to get help",
    ], //13 - 15
    [
      "Tries to say three or more words besides “mama” or “dada”",
      "Follows one-step directions without any gestures, like giving you the toy when you say, “Give it to me.”",
    ], //16 - 18
    [
      "Understands more words than they use in their speech",
      "Have an easier time understanding instructions such as, “Go get your blankie from your room,” and questions like, “Where’s Daddy?” even if the person isn’t in the room",
      "Can name some of the things they see around them or in picture books, often pointing to them at the same time",
      "Start to construct two-word “sentences,” such as “More juice” or “Want cookie.”",
    ], //19 - 21
    [
      "Points to things in a book when you ask, like “Where is the bear?”",
      "Says at least two words together, like “More milk.”",
      "Points to at least two body parts when you ask him to show you",
      "Uses more gestures than just waving and pointing, like blowing a kiss or nodding yes",
    ], //22 - 24
    [
      "Can answer more questions (e.g., “Who’s coming?” and “What are you doing?”)",
      "Understand concepts such as in, up, and down",
      "Use various types of words, including verbs, some adjectives, and articles (e.g., a, the)",
      "Can form simple two- and three-word sentences (e.g., “Mommy eats apple”)",
      "Can conjugate verbs in the present tense when forming these simple “sentences” (e.g., “Daddy pours milk”)",
      "Start to use me when referring to themself",
    ], //25 - 27
    [
      "Says about 50 words",
      "Says two or more words together, with one action word, like “Doggie run”",
      "Names things in a book when you point and ask, “What is this?”",
      "Says words like “I,” “me,” or “we”",
    ], //28 - 30
    [
      "Can follow more complex instructions, e.g., “Go get your coat and put your hat on.”",
      "Can ask questions using words such as who, what, and where",
      "Make more comments than before (e.g., “Oh, what a pretty puppy!”)",
      "Able to hold short conversations with adults and other children",
      "They combine at least three words most of the time (e.g., “Daddy runs fast”)",
      "Often conjugate the verbs they use (e.g., “Mom says no” or “Dad will help”)",
      "They are increasingly able to use small words such as a, the, me, or to correctly",
      "Getting better at sounding out words, even if they aren’t always understood by people who don’t know them very well",
    ], //31 - 33
    [
      "Talks with you in conversation using at least two back-and-forth exchanges",
      "Asks “who,” “what,” “where,” or “why” questions, like “Where is mommy/daddy?”",
      "Says what action is happening in a picture or book when asked, like “running,” “eating,” or “playing”",
      "Says first name, when asked",
      "Talks well enough for others to understand, most of the time",
    ], //34 - 36
  ];
  static List<List<String>> emotionals = [
    [
      "Recognizes parent's voice",
      "When upset, responds to a parent's cuddles, voice, and affections",
      "Becomes alert when hearing a pleasant sound, like music",
    ], //1
    [
      "Calms down when spoken to or picked up",
      "Looks at your face",
      "Seems happy to see you when you walk up to her",
      "Smiles when you talk to or smile at her",
    ], //2
    [
      "Begins to develop a social smile",
      "Enjoys playing with other people and may cry when playing stops",
      "Becomes more communicative and expressive with face and body",
      "Imitates some movements and facial expressions",
    ], //3
    [
      "Smiles on his own to get your attention",
      "Chuckles (not yet a full laugh) when you try to make her laugh",
      "Looks at you, moves, or makes sounds to get or keep your attention",
    ], //4
    [
      "Laughing",
      "Squealing",
      "Smiling with happiness",
      "Joy and pleasure",
    ], //5
    [
      "Knows familiar people",
      "Likes to look at himself in a mirror",
      "Laughs",
    ], //6
    [
      "Enjoys social play",
      "Interested in mirror images",
      "Responds to other people’s expressions of emotion and appears joyful often",
    ], //7
    [
      "Develop “separation anxiety”",
      "Learn the concept of self when they look in the mirror and recognize themself",
    ], //8
    [
      "Is shy, clingy, or fearful around strangers",
      "Shows several facial expressions, like happy, sad, angry, and surprised",
      "Looks when you call her name",
      "Reacts when you leave (looks, reaches for you, or cries)",
      "Smiles or laughs when you play peek-a-boo",
    ], //9
    [
      "Baby is getting better at telling people apart and recognizing different facial expressions",
      "Pay attention to and are influenced by your emotional reactions",
      "Get upset, they may crawl away, rock back and forth, cuddle a security blanket, or suck their thumb or an object to soothe themselves",
      "Shows affection with hugs, kisses, cuddles, and smiles",
    ], //10
    [
      "Can express sadness, joy, anger, fear, hurt, and discomfort and are attentive to these emotions in others",
      "Start to seek affection when they’re upset (e.g., by reaching up to be held)",
    ], //11
    [
      "Plays games with you, like pat-a-cake",
    ], //12
    [
      "Copies other children while playing, like taking toys out of a container when another child does",
      "Shows you an object she likes",
      "Claps when excited ο Hugs stuffed doll or other toy",
      "Shows you affection (hugs, cuddles, or kisses you)",
    ], //13 - 15
    [
      "Puts hands out for you to wash them",
      "Looks at a few pages in a book with you",
      "Helps you dress him by pushing arm through sleeve or lifting up foot",
    ], //16 - 18
    [
      "Can recognize themselves in mirrors, photographs, and videos. They have a sense of individuality and can express their desires and intentions",
      "Can express self-conscious emotions, such as shame, guilt",
      "Greatly influenced by parents emotional reactions and shifting moods, and rely on trusted adults to know how to react to situations",
      "Have rapid mood swings and show their disagreement by sulking, yelling, or adopting aggressive behaviours like biting and hitting",
    ], //19 - 21
    [
      "Notices when others are hurt or upset, like pausing or looking sad when someone is crying",
      "Looks at your face to see how to react in a new situation",
    ], //22 - 24
    [
      "They often refuse to do what you ask, say “no,” and want to make their own decisions",
      "Want to be more autonomous and may refuse your help while getting dressed, for example",
      "Shy and sometimes aggressive around strangers and in unfamiliar places",
      "Enjoys the company of other children but will often get into fights if they play with them",
      "Have difficulty expressing certain emotions, like anger and frustration, and may become aggressive (e.g., hit, bite, pull hair) if they get upset",
      "Becoming aware of the differences between boys and girls",
    ], //25 - 27
    [
      "Plays next to other children and sometimes plays with them",
      "Shows you what she can do by saying, “Look at me!”",
      "Follows simple routines when told, like helping to pick up toys when you say, “It’s clean-up time.”",
    ], //28 - 30
    [
      "Your toddler clearly shows their affection",
      "They start using polite forms of communication such as “please,” “thank you,” and “hello.”",
      "They will happily play next to other children, but may not interact with them",
      "They are increasingly able to play nice and wait their turn",
      "They play make-believe, namely by mimicking adult behaviour",
      "They start to feel more comfortable around strangers",
    ], //31 - 33
    [
      "Calms down within 10 minutes after you leave her, like at a childcare drop off",
      "Notices other children and joins them to play",
    ], //34 - 36
  ];
}

class MilestoneScreen extends StatefulWidget{
  const MilestoneScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return MilestoneScreenState();
  }
}

class MilestoneScreenState extends State<MilestoneScreen>{
  Widget videoTileBuilder(VideoInfo videoInfo){
    return Container(
      width: 64,
      height: 128,
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Thumbnail,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                videoInfo.title
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<int> ages = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60];
  //for error, whyyyy
  int? selectedAge;
  late List<Widget> tabButtons;
  List<bool> selectedTabs = [
    false,
    false,
    false,
    false,
    //false,
  ];
  int? selectedTabIndex;

  List<Function> bodyBuilders = [];

  int _selectedNavBarIndex = 2;

  @override
  Widget build(BuildContext context) {

    Widget buildTabButton(String name){
      return Container(
        padding: const EdgeInsets.all(12),
        width: 128,
        height: 82,
        alignment: Alignment.center,
        child: Text(
          name,
          style: const TextStyle(
            color: Color.fromARGB(255, 95, 109, 126),
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    List<Widget> tabButtons =
    [
      buildTabButton("Movement"),
      buildTabButton("Cognitive"),
      buildTabButton("Communication"),
      buildTabButton("Emotional"),
      //buildTabButton("Activities"),
    ];

    selectedAge ??= Provider.of<ChildProfileProvider>(context, listen: false).getCurrentProfile()?.getAge();
    if(selectedAge == 0){
      selectedAge = selectedAge! + 1;
    }
    selectedAge ??= 1; //default value if profile is still null
    int dataIndex;
    if (selectedAge! <= 12){
      dataIndex = selectedAge! - 1;
    }
    else if (selectedAge! <= 36){
      dataIndex = 12 + (selectedAge! - 13) ~/ 3;
    }
    else {
      dataIndex = 19;
    }

    Widget buildInfo(List<List<String>> info, int dataIndex){
      List<Widget> infos = [];
      for (var element in info[dataIndex]) {
        infos.add(Text(
          element,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Color.fromARGB(255, 95, 109, 126),
            fontWeight: FontWeight.w500,

          ),
        ));
        infos.add(const SizedBox(height: 32,));
      }
      return ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: infos,
          )
        ],
      );
    }

    bodyBuilders = [
          (){ //----------MOVEMENT----------//
        return Container(
          alignment: Alignment.center,
          child: buildInfo(MilestoneData.movements, dataIndex),
        );
      },
          (){ //----------COGNITIVE----------//
        return Container(
          alignment: Alignment.center,
          child: buildInfo(MilestoneData.cognitives, dataIndex),
        );
      },
          (){ //----------COMMUNICATION----------//
        return Container(
          alignment: Alignment.center,
          child: buildInfo(MilestoneData.communications, dataIndex),
        );
      },
          (){ //----------EMOTIONAL----------//
        return Container(
          alignment: Alignment.center,
          child: buildInfo(MilestoneData.emotionals, dataIndex),
        );
      },
          (){ //----------ACTIVITIES----------//
        return Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Activities'),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoScreen()));
                },
                child: const Text('Screen Video'),
              )
            ],
          ),
        );
      },
    ];

    List<Function> actions = [
          (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return HomeScreen();
        }));
      },
          (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return TrackerScreen();
        }));
      },
          (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return MilestoneScreen();
        }));
      },
    ];

    Widget buildBody(){
      if (selectedTabIndex != null){
        if (selectedTabIndex! != 5){ //Not Activities
          return Container(
            padding: const  EdgeInsets.all(16),
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 25, 204, 168),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            child: Column(
              children: [
                const Text(
                  "Developmental Checklist",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 184, 239, 228),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: bodyBuilders[selectedTabIndex!](),
                  ),
                ),
              ],
            ),
          );
        }
        else {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(),
              ],
            ),
          );
        }
      }
      else{
        return Container(
          alignment: Alignment.center,
          child: const Text("Select Any Tab"),
        );
      }
    }

    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.black,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    "Milestones",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 16,),
                  Container(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 20, 163, 134),
                      borderRadius: BorderRadius.all(Radius.circular(64)),
                    ),
                    child: DropdownButton(
                      dropdownColor: const Color.fromARGB(255, 20, 163, 134),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                      underline: Container(),
                      value: selectedAge,
                      items: ages.map<DropdownMenuItem<int>>(
                              (int value){
                            return DropdownMenuItem(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Month ${value.toString()}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }
                      ).toList(),
                      onChanged: (int? value) {
                        if (value != null){
                          setState(() {
                            selectedAge = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 64,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ToggleButtons(
                    selectedBorderColor: Colors.transparent,
                    selectedColor: Colors.transparent,
                    //fillColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    onPressed: (index){
                      setState(() {
                        for (int i = 0; i < selectedTabs.length; i++) {
                          selectedTabs[i] = i == index;
                          selectedTabIndex = index;
                        }
                      });
                    },
                    isSelected: selectedTabs,
                    children: tabButtons,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: buildBody(),
            ),
          ],
        ),
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
        onTap: (int index){
          setState(() {
            _selectedNavBarIndex = index;
            actions[index]();
          });
        },
      ),
    );
  }
}