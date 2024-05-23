# magic_ball

Magic Ball with predictions using API

---
## Intro

I've been wanting to try adding Rive animation to an app written in Flutter for a long time. What I need to do this:
- Rive file: [Unlucky 8 ball - randomise feature](https://rive.app/community/files/9961-18989-unlucky-8-ball-randomise-feature/)
- [8Ball API](https://www.eightballapi.com/docs)
- [Rive package](https://pub.dev/packages/rive/install)

Useful links:
- [Flutter x Rive – create smooth Flutter animations](https://applover.com/blog/flutter-x-rive-create-smooth-flutter-animations/)
- [Rive animations in Flutter](https://www.geeksforgeeks.org/rive-animations-in-flutter/)
- [Rive for Flutter Animations](https://medium.com/@RotenKiwi/rive-for-flutter-animations-a99bfdd8f6cc)

---

First, let's turn to the [Introduction page](https://help.rive.app/) and [Rive Flutter documentation](https://help.rive.app/runtimes/overview/flutter) and try to look at the basic code with the machine.

```dart
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() => runApp(MaterialApp(
      home: MyRiveAnimation(),
    ));

class MyRiveAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RiveAnimation.network(
          'https://cdn.rive.app/animations/vehicles.riv',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
```

It's very simple! Now let's try to make our own Magic Ball app that will give predictions using API when you tap or shake your phone.

You can find more Flutter examples [here](https://github.com/rive-app/rive-flutter/blob/master/example/lib/main.dart)

---

## Implementation

This is not a guide on how to use Rive and Flutter. I'm just describing one particular case and adding useful material.

#### 1. [Select](https://rive.app/community/files/9961-18989-unlucky-8-ball-randomise-feature/) Preview in Rive

We can add this file to ourselves after which change as we need. 
We will be using the file via assets, so we need to download the animation file.

#### 2. In the window that opens, click on the drop-down menu and select export.

We should end up with a .riv file and add it to our assets folder

#### 3. Add our downloaded animation to the project

main.dart
```dart 
import 'package:flutter/material.dart';
import 'package:magic_ball/screens/magic_ball.dart';

void main() => runApp(const MaterialApp(
      home: MagicBallScreen(),
      debugShowCheckedModeBanner: false,
    ));

```

magic_ball.dart
``` dart
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({super.key});

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RiveAnimation.asset(
          'assets/magic_ball.riv',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

```

#### 4. StateMachines (Add intelligence to your animations)

In this StateMachine, you can define different animation states and their transitions. For each state, you can specify an animation to play.

In our case, we need to add an action animation for clicking on the ball.

