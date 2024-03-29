import 'dart:convert';
import 'package:ey_hack/privacy2.dart';
import 'package:ey_hack/screens/seasons.dart';
import 'package:ey_hack/universal/apicall.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  final String title;
  final String desc;
  final String backgroundimg;
  final String logoimgurl;
  final List<String> genres;
  final List<String> castlist;
  final int id;
  final String type;

  Details({
    required this.title,
    required this.desc,
    required this.backgroundimg,
    required this.logoimgurl,
    required this.genres,
    required this.castlist,
    required this.id,
    required this.type,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String youtubetitle = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(widget.backgroundimg),
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
                Positioned(
                  top: 70,
                  left: 10,
                  right: 10,
                  child: Image.network(widget.logoimgurl),
                ),
              ],
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    fetchdatayt();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                        Text(
                          "Play",
                          style: GoogleFonts.dmSerifText(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    addwish();
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.library_add,
                          color: Colors.amber,
                        ),
                        Text(
                          " WishList",
                          style: GoogleFonts.dmSerifText(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                widget.title,
                style: GoogleFonts.dmSerifText(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ),
            Container(
              height: 60,
              margin: const EdgeInsets.only(left: 15),
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.genres.length,
                itemBuilder: (context, index) {
                  final genreName = widget.genres[index];
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyWidget(
                                text: genreName,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(15)),
                          margin: const EdgeInsets.only(left: 0, right: 10),
                          child: Text(
                            genreName,
                            style: GoogleFonts.dmSerifText(
                                color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: const Icon(
                          Icons.circle,
                          color: Colors.grey,
                          size: 10,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                widget.desc,
                style:
                    GoogleFonts.dmSerifText(color: Colors.grey, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Seasons",
                    style: GoogleFonts.dmSerifText(
                        color: Colors.black, fontSize: 30),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    fetchdatayt();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Seasons(title: widget.title, id: widget.id),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.amber,
                    size: 50,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Cast",
                style:
                    GoogleFonts.dmSerifText(color: Colors.black, fontSize: 30),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: widget.castlist.length,
                itemBuilder: (context, index) {
                  final castName = widget.castlist[index];
                  return Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          color: Colors.black,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          castName,
                          style: GoogleFonts.dmSerifText(
                              color: Colors.grey, fontSize: 18),
                        ),
                      ],
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

  void fetchdatayt() async {
    final url = Uri.https(
      'streamlinewatch-streaming-guide.p.rapidapi.com',
      '/search/',
      {
        'type': widget.type,
        'query': widget.title,
        'limit': '1',
      },
    );

    final headers = {
      'X-RapidAPI-Key': apikey2,
      'X-RapidAPI-Host': 'streamlinewatch-streaming-guide.p.rapidapi.com',
    };

    final response = await http.get(url, headers: headers);
    final body = response.body;
    final json = jsonDecode(body);

    final ytid = json[0]["_id"];

    final url2 = Uri.https(
      'streamlinewatch-streaming-guide.p.rapidapi.com',
      '/shows/${ytid}',
      {'platform': 'web', 'region': 'US'},
    );

    final response2 = await http.get(url2, headers: headers);
    final body2 = response2.body;
    final json2 = jsonDecode(body2);

    youtubetitle = json2[0]["youtube_trailer"];
    print(youtubetitle);
  }

  Future<void> addwish() async {
    String wishtitletoadd = widget.title;
    String posterurltoadd = widget.backgroundimg;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String wishtitle = prefs.getString("wishlisttitless") ?? '';
    String posterurl = prefs.getString("wishlistphotoss") ?? '';

    if (wishtitle.contains(wishtitletoadd)) {
      print("already there");
    } else if (wishtitle.isEmpty) {
      wishtitle = wishtitletoadd;
      posterurl = posterurltoadd;
      await prefs.setString("wishlisttitless", wishtitle);
      await prefs.setString("wishlistphotoss", posterurl);
      print("list was empty ");
      print(posterurl);
    } else {
      String savetitle = wishtitle + ";" + wishtitletoadd;
      String saveurl = posterurl + ";" + posterurltoadd;
      await prefs.setString("wishlisttitless", savetitle);
      await prefs.setString("wishlistphotoss", saveurl);
      print(saveurl);
    }
  }
}
