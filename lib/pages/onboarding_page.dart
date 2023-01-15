import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/home.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    var pageDecoration = PageDecoration(
      titleTextStyle:
          const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: const TextStyle(fontSize: 19.0),
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).colorScheme.background,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Welcome!',
          body: 'This app will help you track your habits',
          image: const Text('👋', style: TextStyle(fontSize: 68)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'New habit',
          // body: 'Add new habit by pressing ⊕ button',
          bodyWidget: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(fontSize: 19.0),
              children: [
                TextSpan(
                  text: "Add new habit by pressing ",
                ),
                WidgetSpan(
                  child: Icon(Icons.add_circle_outline, size: 19),
                ),
                TextSpan(
                  text: " button",
                ),
              ],
            ),
          ),
          image: const Text('🆕', style: TextStyle(fontSize: 68)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Mark done',
          body: 'Mark completed days by clicking on the circles',
          image: const Text('📝', style: TextStyle(fontSize: 68)),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Examine statistics',
          body: 'Click on habit block to see extended statistics',
          image: const Text('📊', style: TextStyle(fontSize: 68)),
          decoration: pageDecoration,
        ),
      ],
      showSkipButton: true,
      showNextButton: true,
      skip: const Text("Skip"),
      done: const Text("Done"),
      next: const Text('Next'),
      globalBackgroundColor: Theme.of(context).colorScheme.background,
      onDone: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      },
    );
  }
}
