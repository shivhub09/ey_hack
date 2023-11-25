import 'package:ey_hack/profile.dart';
import 'package:ey_hack/screens/movies.dart';
import 'package:ey_hack/screens/search.dart';
import 'package:ey_hack/screens/tvshows.dart';
import 'package:ey_hack/screens/wishlist.dart';
import 'package:ey_hack/universal/fetchdata.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _text = '';
  late String choices;
  late List<String> finalchoices;

  Future<void> fetchStringFromSharedPreferences() async {
    final List<String> listofchoices = [
      "Sports",
      "Thriller",
    ];
    setState(() {
      finalchoices = listofchoices;
    });
  }

  @override
  void initState() {
    fetchStringFromSharedPreferences();
    super.initState();

    initBannerAd();
    initInterstitialAd();
    initmInterstitialAd();
  }

  late BannerAd bannerAd;
  bool isAdloaded = false;

  late InterstitialAd interstitialad;
  bool isinteradloaded = false;

  initInterstitialAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/8691691433',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          interstitialad = ad;
          setState(() {
            isinteradloaded = true;
          });
        }, onAdFailedToLoad: ((error) {
          interstitialad.dispose();
        })));
  }

  late InterstitialAd minterstitialad;
  bool isminteradloaded = false;

  initmInterstitialAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          minterstitialad = ad;
          setState(() {
            isminteradloaded = true;
          });
        }, onAdFailedToLoad: ((error) {
          interstitialad.dispose();
        })));
  }

  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-3940256099942544/6300978111',
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isAdloaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            print(error);
          },
        ),
        request: const AdRequest());
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: isAdloaded
          ? SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: AdWidget(ad: bannerAd),
            )
          : SizedBox(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30), // Spacer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Profile(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      "assets/ey.png",
                      fit: BoxFit.fill,
                      height: 20,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TvShows(),
                      ),
                    );
                  },
                  child: Text(
                    "TV Shows",
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      {MaterialPageRoute(builder: (context) => Movies())},
                  child: Text(
                    "Movies",
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Wishlist(),
                      ),
                    );
                  },
                  child: Text(
                    "My List",
                    style: GoogleFonts.dmSerifDisplay(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Spacer
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 50,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      // Add a boxShadow here
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.3), // Shadow color and opacity
                        blurRadius: 5, // Spread of the shadow
                        offset: const Offset(0, 3), // Offset of the shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      setState(() {
                        _text = value;
                        print(_text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search(
                              searchtext: _text,
                            ),
                          ),
                        );
                        Search(
                          searchtext: _text,
                        );
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    style: GoogleFonts.dmSerifText(
                      color: Colors.yellow,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorStyle: GoogleFonts.dmSerifText(),
                      hintText: 'Search',
                      hintStyle: GoogleFonts.dmSerifText(color: Colors.grey),
                      icon: const Padding(
                        padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20), // Spacer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (isminteradloaded) {
                          minterstitialad.show();
                        }
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "My List",
                      style: GoogleFonts.dmSerifDisplay(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (isinteradloaded) {
                      interstitialad.show();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Play",
                          style: GoogleFonts.dmSerifDisplay(
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.black,
                    ),
                    Text(
                      "Info",
                      style: GoogleFonts.dmSerifDisplay(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            ListView.builder(
              padding: EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: finalchoices.length,
              itemBuilder: (context, index) {
                return DataWidget(text: finalchoices[index]);
              },
            )
          ],
        ),
      ),
    );
  }

  Future<List<String>> getStringFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    choices = prefs.getString("choices") ?? '';
    List<String> listofchoices = choices.split(";");
    return listofchoices;
  }
}
