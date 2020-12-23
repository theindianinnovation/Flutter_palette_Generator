import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Palette Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> images = [
    'assets/I1.jpg',
    'assets/I3.jpg',
    'assets/I4.jpg'
  ];
  List<PaletteColor> dycolors;
  int _index;

  @override
  void initState() {
    super.initState();
    dycolors = [];
    _index = 0;
    addColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('World Insight'),
        elevation: 0,
        backgroundColor: dycolors.isEmpty
            ? Theme.of(context).primaryColor
            : dycolors[_index].color,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            color: dycolors.isEmpty ? Colors.white : dycolors[_index].color,
            child: PageView(
              onPageChanged: (int index) {
                setState(() {
                  _index = index;
                });
              },
              children: images
                  .map((image) => Container(
                        padding: const EdgeInsets.all(16.0),
                        margin: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                              image: AssetImage(image), fit: BoxFit.cover),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: dycolors.isEmpty ? Colors.white : dycolors[_index].color,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Our Amazing World",
                    style: TextStyle(
                        color: dycolors.isEmpty
                            ? Colors.black
                            : dycolors[_index].titleTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                      "Lorem ipsum dolor sit amet consectetur adipisicing elit. "
                      " Lorem ipsum dolor sit amet consectetur adipisicing elit."
                      "Lorem ipsum dolor sit amet consectetur adipisicing elit."
                      "Lorem ipsum dolor sit amet consectetur adipisicing elit. "
                      " Lorem ipsum dolor sit amet consectetur adipisicing elit."
                      "Lorem ipsum dolor sit amet consectetur adipisicing elit.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: dycolors.isEmpty
                          ? Colors.black
                          : dycolors[_index].bodyTextColor, fontSize: 22.0))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void addColor() async {
    for (String image in images) {
      final PaletteGenerator pg = await PaletteGenerator.fromImageProvider(
          AssetImage(image),
          size: Size(200, 200),
      );
      dycolors.add(pg.lightVibrantColor == null
          ? PaletteColor(Colors.white, 2)
          : pg.lightVibrantColor);
    }
  }
}
