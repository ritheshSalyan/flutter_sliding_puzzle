import 'package:flutter/material.dart';

import 'breakpoints.dart';

typedef ResponsiveWidgetBuilder = Widget Function(
    BuildContext context, BoxConstraints constraints);

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    Key? key,
    this.small,
    this.medium,
    required this.large,
  }) : super(key: key);
  final ResponsiveWidgetBuilder? small;
  final ResponsiveWidgetBuilder? medium;
  final ResponsiveWidgetBuilder large;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= ScreenBreakpoints.small && small != null) {
          return small!.call(context, constraints);
        }
        if (constraints.maxWidth <= ScreenBreakpoints.medium &&
            medium != null) {
          return medium!.call(context, constraints);
        }
        return large.call(context, constraints);
      },
    );
  }
}
