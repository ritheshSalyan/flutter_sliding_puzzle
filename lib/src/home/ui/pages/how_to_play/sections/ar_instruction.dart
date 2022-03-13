import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ARInstruction extends StatelessWidget {
  const ARInstruction({Key? key}) : super(key: key);
  static const String _targetImage = "https://picsum.photos/200/300";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "AR Instructions",
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 50,
        ),
        const Divider(
          thickness: 2,
          endIndent: 30,
          indent: 30,
        ),
        Expanded(child: Image.network(_targetImage)),
        const Divider(
          thickness: 2,
          endIndent: 30,
          indent: 30,
        ),
        Text(
          "Download Marker from",
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        InkWell(
          onTap: () {
            launch(_targetImage);
          },
          child: const SelectableText(_targetImage),
        ),
      ],
    );
  }
}
