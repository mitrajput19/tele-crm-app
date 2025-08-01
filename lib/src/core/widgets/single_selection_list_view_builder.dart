import '../../app/app.dart';

class SingleSelectionListView<T> extends StatefulWidget {
  final List<T>? items;
  final T? selectedValue;
  final Function(T?)? onItemSelected;

  SingleSelectionListView({
    this.items,
    this.selectedValue,
    this.onItemSelected,
  });

  @override
  _SingleSelectionListViewState createState() => _SingleSelectionListViewState<T>();
}

class _SingleSelectionListViewState<T> extends State<SingleSelectionListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items?.length,
      itemBuilder: (context, index) {
        final item = widget.items?[index];
        final isSelected = item == widget.selectedValue;
        return ListTile(
          title: Text(item.toString()),
          onTap: () => widget.onItemSelected!(item),
          tileColor: isSelected ? Colors.blue : null,
          selected: isSelected,
          selectedTileColor: Colors.blue,
        );
      },
    );
  }
}
