import '../../app/app.dart';

class AppColors {
  AppColors._privateConstructor();

  static final MaterialColor lightPrimary = buildMaterialColor(
    const Color(0xFF4C50A4),
  );

  static final MaterialColor darkPrimary = buildMaterialColor(
    const Color(0xFF30444F),
  );

  static final MaterialColor secondary = buildMaterialColor(
    const Color(0xFF53C0C9),
  );

  static final MaterialColor light = buildMaterialColor(
    const Color(0xFFFFFFFF),
  );
  static final MaterialColor gray = buildMaterialColor(
    const Color(0xFF8D8E8F),
  );
  static final MaterialColor dark = buildMaterialColor(
    const Color(0xFF161718),
  );

  static final MaterialColor success = buildMaterialColor(
    const Color(0xFF1EE0AC),
  );
  static final MaterialColor info = buildMaterialColor(
    const Color(0xFF559BFB),
  );
  static final MaterialColor warning = buildMaterialColor(
    const Color(0xFFF4BD0E),
  );
  static final MaterialColor danger = buildMaterialColor(
    const Color(0xFFE85347),
  );

  static final MaterialColor successLight = buildMaterialColor(
    const Color(0xFFC9E5C6),
  );
  static final MaterialColor successDark = buildMaterialColor(
    const Color(0xFF1B8B1D),
  );
  static final MaterialColor infoLight = buildMaterialColor(
    const Color(0xFFE5F4F8),
  );
  static final MaterialColor infoDark = buildMaterialColor(
    const Color(0xFF3C97B1),
  );
  static final MaterialColor warningLight = buildMaterialColor(
    const Color(0xFFFFE5AF),
  );
  static final MaterialColor warningDark = buildMaterialColor(
    const Color(0xFFBB7E1D),
  );
  static final MaterialColor dangerLight = buildMaterialColor(
    const Color(0xFFF6E4E6),
  );
  static final MaterialColor dangerDark = buildMaterialColor(
    const Color(0xFFF04D4E),
  );
  static final MaterialColor pinkLight = buildMaterialColor(
    const Color(0xFFF9EBF6),
  );
  static final MaterialColor pinkDark = buildMaterialColor(
    const Color(0xFFE076C9),
  );

  static final MaterialColor cyan = buildMaterialColor(
    const Color(0xFF53C0C9),
  );
  static final MaterialColor darkBlue = buildMaterialColor(
    const Color(0xFF1B71B7),
  );
  static final MaterialColor lime = buildMaterialColor(
    const Color(0xFF84CC16),
  );

  static final MaterialColor green = buildMaterialColor(
    Color(0xFF2BE72B),
  );

  static final MaterialColor blue = buildMaterialColor(
    Color(0xFF2B80E7),
  );

  static final MaterialColor greyLight = buildMaterialColor(
    Color(0xFFA3A3A3),
  );

  static final MaterialColor greyWhite = buildMaterialColor(
    Color(0xFFD8D8D8),
  );

  static final MaterialColor white = buildMaterialColor(
    const Color(0xFFFFFFFF),
  );
  static final MaterialColor black = buildMaterialColor(
    const Color(0xFF000000),
  );

  static final Color lightBackground = const Color(0xFFFFFFFF);
  static final Color darkBackground = const Color(0xFF121212);

  static final Color lightCardBackground = const Color(0xFFF9F9FA);
  static final Color darkCardBackground = const Color(0xFF2A2A2A);
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
