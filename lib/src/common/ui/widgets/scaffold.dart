import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_puzzle/src/common/ui/theme/theme_provider.dart';
import 'package:sliding_puzzle/src/common/ui/widgets/responsive/responsive_builder.dart';

class CommonScaffold extends ConsumerWidget {
  const CommonScaffold({Key? key,this.small, this.medium, required this.large, }) : super(key: key);
  final ResponsiveWidgetBuilder? small;
  final ResponsiveWidgetBuilder? medium;
  final ResponsiveWidgetBuilder large;
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ref.watch(ThemeNotifier.provider).backgroundColor,
      body: ResponsiveBuilder(large: large,small: small,medium: medium,),
    );
  }
}
