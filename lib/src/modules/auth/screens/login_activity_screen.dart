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
    fetchLoginLogsData(false);
  }

  Future fetchLoginLogsData(bool isMore) async {
    authBloc.add(FetchLoginLogsDataEvent(isMore));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLogsLoadingState) isLoading = state.isLoading;

        if (state is LoginLogsLoadingMoreState) isLoadingMore = state.isLoadingMore;

        if (state is LoginLogsLoadedState) {
          loginLogsDetailsList = state.loginLogsDetailsList ?? [];
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppTrKeys.loginActivity.tr(context)),
          ),
          body: CommonRefreshIndicator(
            onRefresh: () async => fetchLoginLogsData(false),
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
                        onPressed: () => fetchLoginLogsData(true),
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
