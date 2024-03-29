import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:ey_hack/screens/details.dart';
import 'package:ey_hack/privacy.dart';

class TvShows extends StatefulWidget {
  TvShows({super.key});
  @override
  _TvShowsState createState() => _TvShowsState();
}

class _TvShowsState extends State<TvShows> {
  bool isLoading = true;
  List<dynamic> users = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                child: Text(
                  "Tv Shows",
                  style: GoogleFonts.dmSerifText(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Set the number of columns
                        ),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          final type = user["summary"]['type'];

                          final title = user['jawSummary']['title'];
                          final photo =
                              user['jawSummary']['backgroundImage']['url'];
                          final description = user['jawSummary']['synopsis'];
                          final imageurl =
                              user['jawSummary']['backgroundImage']['url'];
                          final logoimgurl =
                              user['jawSummary']['logoImage']['url'];
                          List<Map<String, dynamic>> genres =
                              (user['jawSummary']['genres'] as List<dynamic>)
                                  .cast<Map<String, dynamic>>();
                          List<String> genrelist = genres
                              .map((item) => item["name"] as String)
                              .toList();
                          List<Map<String, dynamic>> castlist =
                              (user['jawSummary']['cast'] as List<dynamic>)
                                  .cast<Map<String, dynamic>>();
                          List<String> cast = castlist
                              .map((item) => item["name"] as String)
                              .toList();
                          int id = user['summary']['id'];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Details(
                                    title: title,
                                    desc: description,
                                    backgroundimg: imageurl,
                                    logoimgurl: logoimgurl,
                                    genres: genrelist,
                                    castlist: cast,
                                    id: id,
                                    type: type,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    width: 200,
                                    margin: const EdgeInsets.all(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        photo,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  title,
                                  style: GoogleFonts.dmSerifText(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
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
      ),
    );
  }

  void fetchData() async {
    final url = Uri.https(
      'netflix-data.p.rapidapi.com',
      '/search/',
      {
        'query': 'hindiseries',
        'offset': '0',
        'limit_titles': '5',
        'limit_suggestions': '1',
      },
    );

    final headers = {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'netflix-data.p.rapidapi.com',
    };

    final response = await http.get(url, headers: headers);

    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      isLoading = false; // Set isLoading to false once data is fetched
      users = json["titles"];
    });
  }
}
