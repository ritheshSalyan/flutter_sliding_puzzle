import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/common/ui/theme/theme_provider.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/responsive/responsive_builder.dart';

class CommonScaffold extends ConsumerWidget {
  const CommonScaffold(
      {Key? key,
      this.small,
      this.medium,
      required this.large,
      this.actions = const []})
      : super(key: key);
  final ResponsiveWidgetBuilder? small;
  final ResponsiveWidgetBuilder? medium;
  final ResponsiveWidgetBuilder large;
  final List<Widget> actions;
  @override
  Widget build(BuildContext context, ref) {
    return DeferredPointerHandler(
      child: Theme(
        data: Theme.of(context).copyWith(
            primaryColor: ref.watch(ThemeNotifier.provider).foregroundColor,
            appBarTheme: Theme.of(context).appBarTheme.copyWith(
                foregroundColor:
                    ref.watch(ThemeNotifier.provider).foregroundColor)),
        child: Scaffold(
          appBar: AppBar(
            actions: actions,
          ),
          backgroundColor: ref
              .watch(ThemeNotifier.provider)
              .backgroundColor, //.withOpacity(0.2),
          body: ResponsiveBuilder(
            large: large,
            small: small,
            medium: medium,
          ),
        ),
      ),
    );
  }
}
