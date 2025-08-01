import '../../../app/app.dart';

Widget buildPickerActionButton(
  BuildContext context, {
  required IconData icon,
  required String label,
  required Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 80,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gray.shade100),
              color: Theme.of(context).cardColor,
            ),
            child: Icon(
              icon,
              size: 20,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.tsMedium14,
          )
        ],
      ),
    ),
  );
}
