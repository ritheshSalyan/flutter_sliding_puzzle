import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/common/common.dart';
import 'package:sliding_puzzle/src/puzzle/provider/difficuly_level.dart';

class Settings extends ConsumerWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return CommonScaffold(
      // backgroundColor: Colors.white,
      // appBar: AppBar(),
      large: (context, constraints) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: context.textTheme.displaySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Select Theme",
              style: context.textTheme.bodyLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(ThemeNotifier.provider.notifier)
                        .changeTheme(context, jungleTheme);
                  },
                  child: const Text("Jungle"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(ThemeNotifier.provider.notifier)
                        .changeTheme(context, iceTheme);
                  },
                  child: const Text("Ice"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Select Difficulty",
              style: context.textTheme.bodyLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(DifficultyNotifier.provider.notifier)
                        .changeDifficulty(DifficulyLevel.easy);
                  },
                  child: const Text("Easy"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(DifficultyNotifier.provider.notifier)
                        .changeDifficulty(DifficulyLevel.medium);
                  },
                  child: const Text("Medium"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(DifficultyNotifier.provider.notifier)
                        .changeDifficulty(DifficulyLevel.hard);
                  },
                  child: const Text("Hard"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
