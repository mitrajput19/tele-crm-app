import '../../app/app.dart';

class CommonLoader extends StatelessWidget {
  final bool hideGif;

  const CommonLoader({
    super.key,
    this.hideGif = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 120,
                height: 140,
                padding: EdgeInsets.all(hideGif ? 8 : 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(hideGif ? 100 : 8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        if (!hideGif) AppLogo(isGifLoading: true),
                        Center(
                          child: Container(
                            height: hideGif ? 22 : 50,
                            width: hideGif ? 22 : 50,
                            child: CircularProgressIndicator(
                              strokeWidth: hideGif ? 2 : 3,
                              strokeCap: StrokeCap.round,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (!hideGif) ...[
                      SizedBox(height: 16),
                      Text(
                        AppTrKeys.loading.tr(context),
                        style: Theme.of(context).textTheme.tsRegular14,
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
