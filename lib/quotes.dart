import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';



class Quotes extends StatefulWidget {
  static final String path = "lib/src/pages//1.dart";

  @override
  State<Quotes> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  late PageController _pageController;

  int currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body:PageView.builder(
          itemCount: demo_data.length,
          controller: _pageController,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Onboarding( title: demo_data[index].title, desc: demo_data[index].desc, ),
                const SizedBox(
                  height: 63,
                ),
               
              ],
            );
          }),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: () {
             Get.offNamed("/home_page");
            }, icon: Icon(Icons.arrow_forward_ios)),

            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class Onboard {
  final String  title, desc;


  Onboard({required this.title, required this.desc, });
}
final List<Onboard> demo_data = [


  Onboard(
    title: "Which band do robots love to listen to?",
    desc: "Metal-lica!",

  ),
  Onboard(

    title: "How do robots pay for things?",
    desc: "With cache, of course!",

  ),
];

class Onboarding extends StatelessWidget {
   Onboarding({Key? key,  this.title, this.desc,}) : super(key: key);
  final  title, desc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 80,
          ),
          //Text("Jack Has A Joke For You!",style: TextStyle(fontSize: 20),),
          Animator(
            triggerOnInit: true,
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 500),
            tween: Tween<double>(begin: -1, end: 0),
            builder: (context, state, child) {
              return FractionalTranslation(
                  translation: Offset(state.value as double, 0), child: child);
            },


            child: Center(
              child: Text(
               " Jack Likes Telling Jokes.",
                style: Theme
                    .of(context)
                    .textTheme
                    .headline5!
                    .copyWith(
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Icon(
                FontAwesomeIcons.quoteLeft,
                size: 30.0,
                color: Colors.grey,
              )),
          const SizedBox(
            height: 16,
          ),
          Animator(
            triggerOnInit: true,
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 500),
            tween: Tween<double>(begin: -1, end: 0),
            builder: (context, state, child) {
              return FractionalTranslation(
                  translation: Offset(state.value as double, 0), child: child);
            },


            child: Text(
                title,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline3!
                  .copyWith(
                color: Colors.cyan,
              ),
            ),
          ),

          const SizedBox(
            height: 9,
          ),

          Animator(
            triggerOnInit: true,
            tween: Tween<double>(begin: 10, end: 0),
            duration:  Duration(seconds: 2),
            builder: (context, state, child) {
              return FractionalTranslation(
                translation: Offset(state.value as double, 0),
                child: child,
              );
            },
            child: Text(
              desc,
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(
                color: Colors.grey.shade600,
                fontSize: 20.0,
              ),
            ),
          ),

          const SizedBox(
            height: 33,
          ),
          Align(
              alignment: Alignment.topRight,
              child: Icon(
                FontAwesomeIcons.quoteLeft,
                size: 30.0,
                color: Colors.grey,
              )),

        ],
      ),
    );
  }
}

/*

Padding(
padding: const EdgeInsets.all(32.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
Animator(
triggerOnInit: true,
curve: Curves.easeIn,
duration: Duration(milliseconds: 500),
tween: Tween<double>(begin: -1, end: 0),
builder: (context, state, child) {
return FractionalTranslation(
translation: Offset(state.value as double, 0), child: child);
},


child: Text(
"Jack has another joke for you!",
style: Theme
    .of(context)
.textTheme
    .headline5!
.copyWith(
color: Colors.green,
),
),
),
SizedBox(height: 20,),
const Align(
alignment: Alignment.topLeft,
child: Icon(
FontAwesomeIcons.quoteLeft,
size: 30.0,
color: Colors.grey,
)),


const SizedBox(height: 10.0),

],
),
),*/
