import 'package:ey_hack/screens/choices.dart';
import 'package:ey_hack/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/background.jpg",
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            height: 80,
            top: 200,
            left: 20,
            child: Image.asset(
              "assets/ey.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              top: 300,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    """WATCH
TV SHOWS &
MOVIES
ANYWHERE.
ANYTIME.""",
                    style: GoogleFonts.dmSerifText(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 40),
                  ),
                  Text(
                    "Plans from \$7.99 a month.",
                    style: GoogleFonts.dmSerifText(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )),
          Positioned(
            bottom: 0,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    width: 195,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Center(
                      child: Text(
                        "Login",
                        style: GoogleFonts.dmSerifText(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    width: 195,
                    decoration: const BoxDecoration(color: Colors.amber),
                    child: Center(
                      child: Text(
                        "Start Free Month",
                        style: GoogleFonts.dmSerifText(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
