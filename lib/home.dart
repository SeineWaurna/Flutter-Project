import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

void main(){
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = new FlutterSecureStorage();

  final ImagePicker _picker = ImagePicker();

  //late VideoPlayerController _controller;

  String btnText = 'Login with Google';
  String btnText2 = 'Login with Facebook';
  bool isLogin = false;
  bool isLogin2 = false;

  String pathImg = '';
  String pathVideo = '';

  Map<String, String> allValues = {};

  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {
    //     _controller.setLooping(true);
    //     _controller.play();
    //     setState(() {});
    //   });
    storage.read(key: 'userType').then((value) {
      if (value != null) {
        if (value == 'google') {
          setState(() {
            btnText = 'Logout with Google';
            isLogin = true;
          });
        } else if (value == 'facebook') {
          setState(() {
            btnText2 = 'Logout with Facebook';
            isLogin2 = true;
          });
        }
      }
    });
    readData();
  }

  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  Future takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        pathImg = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
  }

  Future takeVideo(ImageSource source) async {
    final pickedFile = await _picker.pickVideo(source: source);
    setState(() {
      if (pickedFile != null) {
        pathVideo = pickedFile.path;
      } else {
        print('No video selected.');
      }
    });
  }

  Future readData() async {
    allValues = await storage.readAll();
    setState(() {

    });
  }

  Future loginWithGoogle(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    GoogleSignInAccount? user = await _googleSignIn.signIn();
    GoogleSignInAuthentication userAuth = await user!.authentication;

    storage.write(key: 'userType', value: 'google');
    storage.write(key: 'userName', value: user.displayName.toString());
    storage.write(key: 'userEmail', value: user.email.toString());
    storage.write(key: 'userPhoto', value: user.photoUrl.toString());
    storage.write(key: 'userToken', value: userAuth.accessToken.toString());

    setState(() {
      btnText = 'Logout';
      isLogin = true;
    });
    storage.readAll().then((v) {
      if (v != null) {
        print(v);
      }
    });
    readData();
  }

  Future loginWithFacebook(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      final userData = await FacebookAuth.instance.getUserData();

      storage.write(key: 'userType', value: 'facebook');
      storage.write(key: 'userName', value: userData['name'].toString());
      storage.write(key: 'userEmail', value: userData['email'].toString());
      storage.write(key: 'userPhoto', value: userData['picture']['data']['url'].toString());
      storage.write(key: 'userToken', value: accessToken.token.toString());

      setState(() {
        btnText2 = 'Logout';
        isLogin2 = true;
      });

      storage.readAll().then((v) {
        if (v != null) {
          print(v);
        }
      });
      readData();
    } else {
      print(result.status);
      print(result.message);
    }
  }

  Future logoutWithFB(BuildContext context) async {
    final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      await FacebookAuth.instance.logOut();
      setState(() {
        btnText2 = 'Login with Facebook';
        isLogin2 = false;
      });
      storage.deleteAll();
      allValues = {};
    }
  }

  Future logout(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    await _googleSignIn.signOut();
    setState(() {
      btnText = 'Login with Google';
      isLogin = false;
    });
    storage.deleteAll();
    allValues = {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          InkWell(
            child: Container(
              constraints: const BoxConstraints.expand(height: 50),
              child: Center(child: Text(btnText, style: TextStyle(fontSize: 20, color: Colors.blue[600]))),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[600]!),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.all(12),
            ),
            onTap: () {
              if (isLogin) {
                logout(context);
              } else {
                loginWithGoogle(context);
              }
            },
          ),
          InkWell(
            child: Container(
              constraints: const BoxConstraints.expand(height: 50),
              child: Center(child: Text(btnText2, style: TextStyle(fontSize: 20, color: Colors.blue[600]))),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[600]!),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.all(12),
            ),
            onTap: () {
              if (isLogin2) {
                logoutWithFB(context);
              } else {
                loginWithFacebook(context);
              }
            },
          ),
          allValues.isNotEmpty
              ? Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Text('Name: ' + allValues['userName'].toString()),
                Text('Email: ' + allValues['userEmail'].toString()),
                Image.network(allValues['userPhoto'].toString()),
              ],
            ),
          )
              : Container(),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () => takePhoto(ImageSource.camera),
              child: const Text('Open Camera'),
            ),
          ),
          pathImg != '' ? Container(width: 50, height: 50,child: Image.file(File(pathImg))) : Container(),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () => takePhoto(ImageSource.gallery),
              child: const Text('Open Gallery'),
            ),
          ),
          // _controller.value.isInitialized
          //     ? Container(
          //   margin: const EdgeInsets.all(10),
          //   child: AspectRatio(
          //     aspectRatio: _controller.value.aspectRatio,
          //     child: VideoPlayer(_controller),
          //   ),
          // )
          //     : Container(),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _controller.value.isPlaying
      //           ? _controller.pause()
      //           : _controller.play();
      //     });
      //   },
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }
}
