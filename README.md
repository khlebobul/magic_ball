# magic_ball

Magic Ball with predictions using API

---
## Intro

I've been wanting to try adding Rive animation to an app written in Flutter for a long time. What I need to do this:
- Rive file: [Unlucky 8 ball - randomise feature](https://rive.app/community/files/9961-18989-unlucky-8-ball-randomise-feature/)
- [8Ball API](https://www.eightballapi.com/docs)
- [Rive package](https://pub.dev/packages/rive/install)

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