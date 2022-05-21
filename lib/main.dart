import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Rive Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       home: RiveDemo(),
    );
  }
}


class RiveDemo extends StatefulWidget {
  //  RiveDemo({ Key key}) : super(key: key);
   const RiveDemo({Key? key}) : super(key: key);
   
  @override
  _RiveDemoState createState() => _RiveDemoState();
}

class _RiveDemoState extends State<RiveDemo> {
  bool get isPlaying => _controller.isActive;
  late Artboard _riveArtboard ;
  late RiveAnimationController _controller;
  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/smile.riv').then(
      (data) async {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  void _launchRocket() {
    _riveArtboard.addController(_controller = SimpleAnimation('Smile'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : Rive(artboard: _riveArtboard),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _launchRocket,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

