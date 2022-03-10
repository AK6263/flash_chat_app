import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
/*
  SingleTickerProviderStateMixin : For a Single Animation
  TickerProviderStateMixin : For Multiple Animations

  These allow our _WelcomeScreenState to act as a Ticker Provider 
  Ticker is Essentially a Clock or FPS for state life cycles
*/

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    // vsync = this -> Since the Ticker is provided by the state
    // we can just put the State in here
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      upperBound: 100.0,
    );
    // For adding some flavor to the animation. But Don't forget to remove the
    // UppderBound in the controller since animations go from 0.0 -> 1.0
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    // You can reverse the animation as well but need to
    // provide the range in from to
    // controller.reverse(from: 1.0);

    controller.addListener(() {
      // This Set State allows the color to change
      setState(() {});
      print(controller.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      // backgroundColor: Colors.white,
      // Colors.red.withOpacity(controller.value) for Color animation
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                    // ! For Icon Animation put this in height => controller.value
                  ),
                ),
                TypewriterAnimatedTextKit(
                  textStyle: const TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                  text: const ['Flash Chat'],
                  speed: const Duration(milliseconds: 80),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              color: Colors.lightBlueAccent,
              onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
            ),
            RoundedButton(
              title: 'Register',
              color: Colors.blueAccent,
              onPressed: () =>
                  Navigator.pushNamed(context, RegistrationScreen.id),
            ),
          ],
        ),
      ),
    );
  }
}
