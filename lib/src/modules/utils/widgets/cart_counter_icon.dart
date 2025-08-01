import '../../../app/app.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: Stack(
        children: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart_rounded,
            ),
            onPressed: () => context.push(AppRoutes.shoppingBagsList),
          ),
          Positioned(
            right: 0,
            child: CommonChip(
              label: '10',
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              margin: EdgeInsets.only(right: 4, top: 4),
              labelStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: AppColors.info,
            ),
          ),
        ],
      ),
    );
  }
}
