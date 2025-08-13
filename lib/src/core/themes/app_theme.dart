import '../../app/app.dart';

class AppTheme {
  static const String fontFamily = 'Roboto';
  static const String fontFamilyLevenim = 'Levenim';

  static final double cardBorderRadius = 16;
  static final double buttonBorderRadius = 50;
  static final double textFieldBorderRadius = 12;
  static final double tabbarBorderRadius = 50;

  static final BorderRadius borderRadiusCircularCard = BorderRadius.circular(
    cardBorderRadius,
  );

  static ThemeData themeData(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = BlocProvider.of<AppBloc>(context, listen: true).isDarkMode;
    return ThemeData(
      useMaterial3: false,
      fontFamily: fontFamily,
      primaryTextTheme: Typography.blackCupertino,
      primarySwatch: buildMaterialColor(context.isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary),
      scaffoldBackgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      cardColor: isDarkMode ? AppColors.darkCardBackground : AppColors.lightCardBackground,
      iconTheme: IconThemeData(
        color: isDarkMode ? AppColors.light : AppColors.lightPrimary,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: isDarkMode ? AppColors.light : AppColors.dark,
        selectionHandleColor: isDarkMode ? AppColors.light : AppColors.dark,
        selectionColor: isDarkMode ? AppColors.secondary.shade900 : AppColors.secondary.shade100,
      ),
      textTheme: theme.textTheme.apply(
        fontFamily: fontFamily,
        bodyColor: isDarkMode ? AppColors.light : AppColors.dark,
        displayColor: isDarkMode ? AppColors.light : AppColors.dark,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
        actionsIconTheme: IconThemeData(
          color: isDarkMode ? AppColors.light : AppColors.dark,
        ),
        iconTheme: IconThemeData(
          color: isDarkMode ? AppColors.light : AppColors.dark,
        ),
        titleTextStyle: Theme.of(context).textTheme.tsRegular18.copyWith(
              fontFamily: fontFamilyLevenim,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? AppColors.light : AppColors.dark,
            ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
        ),
        entryModeIconColor: AppColors.secondary,
        dialHandColor: AppColors.secondary,
        dayPeriodColor: AppColors.secondary,
        dayPeriodTextColor: isDarkMode ? AppColors.light : AppColors.dark,
        hourMinuteTextColor: isDarkMode ? AppColors.light : AppColors.dark,
        dialTextColor: isDarkMode ? AppColors.light : AppColors.dark,
        cancelButtonStyle: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(AppColors.secondary),
        ),
        confirmButtonStyle: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(AppColors.secondary),
        ),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        elevation: 0,
        color: AppColors.lightPrimary,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedItemColor: isDarkMode ? AppColors.gray.shade100 : AppColors.gray,
        selectedItemColor: isDarkMode ? AppColors.light : AppColors.dark,
        backgroundColor: isDarkMode ? AppColors.darkCardBackground : AppColors.lightCardBackground,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      ),
    );
  }
}

extension DarkModeExtension on BuildContext {
  bool get isDarkMode => BlocProvider.of<AppBloc>(this).isDarkMode;
}

extension TextThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
