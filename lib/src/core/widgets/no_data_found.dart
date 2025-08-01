import '../../app/app.dart';

class ScrollNoDataFound extends StatelessWidget {
  final String? label;
  final String? message;
  const ScrollNoDataFound({super.key, this.label, this.message});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: NoDataFound(
                label: label, 
                message: message,
              ),
            ),
          ],
        );
      },
    );
  }
}

class NoDataFound extends StatelessWidget {
  final String? label;
  final String? message;
  const NoDataFound({super.key, this.label, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 56),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6).copyWith(right: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 24,
            ),
            SizedBox(width: 8),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label ?? AppTrKeys.noDataFound.tr(context),
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                  if (message != null && message != '')
                    Text(
                      message!,
                      style: Theme.of(context).textTheme.tsRegular12,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
