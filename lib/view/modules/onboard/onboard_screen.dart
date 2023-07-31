import 'package:ecommarce_app/data/local/cache_helper.dart';
import 'package:ecommarce_app/view/modules/login/ui/login_screen.dart';
import 'package:ecommarce_app/widgets/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BordingModel {
  String image;
  String title;
  String body;

  BordingModel({required this.image, required this.title, required this.body});
}

// ignore: must_be_immutable
class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  var pageController = PageController();
  bool lastScreen = false;
  List<BordingModel> bordingScreens = [
    BordingModel(
        image: "assets/images/onboard1.png", title: "title1", body: "body1"),
    BordingModel(
        image: "assets/images/onboard2.png", title: "title2", body: "body2"),
    BordingModel(
        image: "assets/images/onboard3.png", title: "title3", body: "body3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
              padding: const EdgeInsets.only(top: 35),
            child: Text(
              "Shop App",
              style: TextStyle(
                  color: defaultColor, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {
                  CachHelper.saveData(key: "onBoarding", value: true)
                      .then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (route) => false);
                  });
                },
                child: const Row(
                  children: [
                    Text(
                      "SKIP",
                      style: TextStyle(color: defaultColor, fontSize: 17),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: defaultColor,
                      size: 17,
                    )
                  ],
                ))
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (val) {
                    if (val == bordingScreens.length - 1) {
                      setState(() {
                        lastScreen = true;
                      });
                    } else {
                      lastScreen = false;
                    }
                  },
                  controller: pageController,
                  itemBuilder: (context, index) =>
                      bording(bordingScreens[index]),
                  itemCount: bordingScreens.length,
                  physics: const BouncingScrollPhysics(),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: bordingScreens.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      spacing: 5,
                      dotWidth: 10,
                      expansionFactor: 4,
                      activeDotColor: defaultColor,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: defaultColor,
                    onPressed: () {
                      if (lastScreen) {
                        CachHelper.saveData(key: "onBoarding", value: true)
                            .then((value) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                              (route) => false);
                        });
                      } else {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }

  Widget bording(BordingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage("${model.image}"))),
          SizedBox(
            height: 15,
          ),
          Text(
            "${model.title}",
            style: TextStyle(fontSize: 28),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "${model.body}",
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      );
}
