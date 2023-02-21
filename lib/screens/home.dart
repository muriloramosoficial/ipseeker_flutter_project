import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipseekr/services/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 26, 26, 26)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your IP'.toUpperCase(),
                style: GoogleFonts.acme(
                  textStyle: Theme.of(context).textTheme.displayMedium,
                  color: Colors.white,
                ),
              ),
              Container(
                width: 340,
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 20, bottom: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(61, 255, 255, 255),
                  borderRadius: BorderRadius.all(
                    Radius.circular(60),
                  ),
                ),
                child: StreamBuilder(
                  stream: ipApi.getIp(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      // ignore: prefer_const_constructors
                      return Center(
                        child: Text(
                          'Loading...',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SelectableText(
                          '${snapshot.data}',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: snapshot.data),
                            );
                            // key.currentState!.showSnackBar(SnackBar(
                            //   content: new Text("Copied to Clipboard"),
                            // ));
                          },
                          icon: Icon(Icons.copy),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
