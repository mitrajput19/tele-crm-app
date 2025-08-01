import '../../app/app.dart';

extension StringTranslationExtension on String {
  static final htmlEntities = {
    // Basic quotes and apostrophes
    '&#039;': "'",
    '&#39;': "'",
    '&apos;': "'",
    '&quot;': '"',
    '&#34;': '"',

    // Spaces and breaks
    '&nbsp;': ' ',
    '&#160;': ' ',
    '&ensp;': ' ',
    '&#8194;': ' ',
    '&emsp;': ' ',
    '&#8195;': ' ',
    '&thinsp;': ' ',
    '&#8201;': ' ',
    '&shy;': '',

    // Basic symbols
    '&amp;': '&',
    '&#38;': '&',
    '&lt;': '<',
    '&#60;': '<',
    '&gt;': '>',
    '&#62;': '>',
  };

  String decodeString() {
    return htmlEntities.entries.fold(this, (decoded, entry) {
      return decoded.replaceAll(entry.key, entry.value);
    });
  }

  String tr(BuildContext context) {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);

    // Get the current translation
    String getTranslation() {
      String converted = this.split('_').map((word) {
        return word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1);
      }).join(' ');

   
      return converted.decodeString();
    }

    // For first render
    if (!context.mounted) getTranslation();

    // Set up the listener for changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appBloc.translationNotifier.addListener(() {
        if (context.mounted) (context as Element).markNeedsBuild();
      });
    });

    // LogHelper.log('Translation : $this : ${getTranslation()}');

    return getTranslation();
  }

  // String tr(BuildContext context, {bool listen = true}) {
  //   AppBloc appBloc = BlocProvider.of<AppBloc>(context, listen: listen);
  //   List<TranslationModelAdaptor>? translations = appBloc.translationList;

  //   String converted = this.split('_').map((word) {
  //     return word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1);
  //   }).join(' ');

  //   TranslationModelAdaptor? data = translations?.firstWhere(
  //     (element) => element.translationKeywordKey == this,
  //     orElse: () => TranslationModelAdaptor(),
  //   );
  //   return (data?.translationValue ?? converted).decodeString();
  // }
}
