import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ColorMixer(),
    );
  }
}

class ColorMixer extends StatefulWidget {
  @override
  _ColorMixerState createState() => _ColorMixerState();
}

class _ColorMixerState extends State<ColorMixer> {
  bool isYellowSelected = false;
  bool isRedSelected = false;
  bool isBlueSelected = false;

  Color mixedColor = Colors.white;

  void mixColors() {
    List<Color> selectedColors = [];

    if (isYellowSelected) selectedColors.add(Colors.yellow);
    if (isRedSelected) selectedColors.add(Colors.red);
    if (isBlueSelected) selectedColors.add(Colors.blue);

    if (selectedColors.isNotEmpty) {
      mixedColor = selectedColors
          .reduce((value, element) => Color.lerp(value, element, 0.5)!);
    } else {
      mixedColor = Colors.white;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Mixer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Please choose two or more colors."),
            const SizedBox(height: 20),
            buildColorCheckbox(Colors.yellow, 'Y', isYellowSelected, (value) {
              setState(() {
                isYellowSelected = value!;
              });
            }),
            const SizedBox(height: 10),
            buildColorCheckbox(Colors.red, 'R', isRedSelected, (value) {
              setState(() {
                isRedSelected = value!;
              });
            }),
            const SizedBox(height: 10),
            buildColorCheckbox(Colors.blue, 'B', isBlueSelected, (value) {
              setState(() {
                isBlueSelected = value!;
              });
            }),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: mixColors,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Mix Colors',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: mixedColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // تغيير الظل
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'Mixed Color',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildColorCheckbox(Color color, String label, bool isSelected,
      ValueChanged<bool?>? onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Checkbox(
          value: isSelected,
          onChanged: onChanged,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          activeColor: color,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
