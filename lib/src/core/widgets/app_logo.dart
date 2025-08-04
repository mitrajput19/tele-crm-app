
import '../../app/app.dart';

class AppLogo extends StatelessWidget {
  final double? size;
  final bool isGifLoading;
  final bool isLightTheme;

  const AppLogo({
    super.key,
    this.size = 120,
    this.isGifLoading = false,
    this.isLightTheme = false,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          child: isGifLoading
              ? Image.asset(
                  Assets.assetsImagesHomeReviseTeleLogo,
                  height: 50,
                  width: 50,
                )
              : Image.asset(
                  isLightTheme
                      ? Assets.assetsImagesHomeReviseLogo
                      : context.isDarkMode
                          ? Assets.assetsImagesHomeReviseTeleLogo
                          : Assets.assetsImagesHomeReviseTeleLogo,
                  height: size ?? 120,
                ),
        ),
      ),
    );
  }
}
