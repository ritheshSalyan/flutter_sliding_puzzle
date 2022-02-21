import 'package:flutter_modular/flutter_modular.dart';
import 'package:sliding_puzzle/src/puzzle/puzzle.dart';

import 'src/home/ui/pages/home_page.dart';
import 'src/puzzle/view/page/ar_puzzle_page.dart';

class AppModule extends Module {
  static const home = "/";
  static const game = "/game";
  static const argame = "/argame";
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(home, child: (context, args) => const HomePage()),
        ChildRoute(game, child: (context, args) => const PuzzlePage()),
        ChildRoute(argame, child: (context, args) => const ARPuzzlePage()),
      ];
}
