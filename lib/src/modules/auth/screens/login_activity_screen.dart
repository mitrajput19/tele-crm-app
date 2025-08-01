import '../../../app/app.dart';

class LoginActivityScreen extends StatefulWidget {
  const LoginActivityScreen({super.key});

  @override
  _LoginActivityScreenState createState() => _LoginActivityScreenState();
}

class _LoginActivityScreenState extends State<LoginActivityScreen> {
  late AuthBloc authBloc;

  bool isLoading = false;
  bool isLoadingMore = false;

  List<LoginLogDetails> loginLogsDetailsList = [];

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.loginLogDetails = [];
    authBloc.lastLoaded = 0;

  }



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
       
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppTrKeys.loginActivity.tr(context)),
          ),
          body: CommonRefreshIndicator(
            onRefresh: () async {},
            child: Visibility(
              visible: isLoading,
              child: ListViewShimmer(),
              replacement: Visibility(
                visible: loginLogsDetailsList.isEmpty,
                child: ScrollNoDataFound(),
                replacement: ResponsiveLayoutBuilder(
                  padding: EdgeInsets.all(16).copyWith(bottom: 100, top: 8),
                  itemCount: loginLogsDetailsList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == loginLogsDetailsList.length) {
                      return CommonOutlinedButton(
                        isLoading: isLoadingMore,
                        label: AppTrKeys.loadMore.tr(context),
                        onPressed: () {},
                      );
                    } else {
                      final loginLogDetails = loginLogsDetailsList[index];
                      return LoginLogDetailCard(loginLogDetails: loginLogDetails);
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
