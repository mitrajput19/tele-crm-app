import '../../app/app.dart';

class AppLanguageBottomSheet extends StatefulWidget {
  const AppLanguageBottomSheet({Key? key}) : super(key: key);

  @override
  State<AppLanguageBottomSheet> createState() => _AppLanguageBottomSheetState();
}

class _AppLanguageBottomSheetState extends State<AppLanguageBottomSheet> {
  late AppBloc appBloc;
  late AuthBloc authBloc;
  late TranslationLanguage? selectedLanguage;

  @override
  void initState() {
    super.initState();
    initBloc();
  }

  void initBloc() {
    appBloc = BlocProvider.of<AppBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);
    selectedLanguage = appBloc.selectedLanguage ??
        TranslationLanguage(
          translationLanguageId: 1,
        );
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheet(
      hasSearch: false,
      hasBottomSpacing: false,
     
      children: [
        BlocConsumer<AppBloc, AppState>(
          bloc: appBloc,
          listener: (context, state) {
            if (state is AppSelectedLanguageState) {
              selectedLanguage = state.selectedLanguage;
            }
          },
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: appBloc.translationLanguageList?.length ?? 0,
              itemBuilder: (context, index) {
                var item = appBloc.translationLanguageList?[index];
                return CommonSelectionListTile(
                  isDense: true,
                  hasLeadingIcon: false,
                  padding: EdgeInsets.zero,
                  label: appBloc.translationLanguageList?[index].translationLanguageName,
                  isSelected: selectedLanguage?.translationLanguageId == item?.translationLanguageId,
                  onTap: () {
                    context.pop();
                    appBloc.add(AppSelectedLanguageEvent(item ?? TranslationLanguage(translationLanguageId: 1)));
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
