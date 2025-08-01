import '../../app/app.dart';

mixin SearchableMixin<T extends StatefulWidget> on State<T> {
  bool isSearchVisible = false;
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  late void Function(String) filterFunction;
  void Function()? onSearchClose;

  void initializeSearch(
    void Function(String searchTerm) filter, {
    void Function()? onClose,
  }) {
    filterFunction = filter;
    onSearchClose = onClose;
  }

  void triggerCloseSearch() {
    searchController.text = '';
    isSearchVisible = false;
    setState(() {});
  }

  void filterList(String searchTerm) {
    filterFunction(searchTerm);
    setState(() {});
  }

  void openSearch() {
    searchController.text = '';
    if (onSearchClose == null) {
      filterFunction('');
    }
    if (isSearchVisible) {
      Future.delayed(Duration(milliseconds: 1500), () {
        onSearchClose?.call();
      });
    }
    setState(() => isSearchVisible = !isSearchVisible);
    Future.delayed(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(searchFocusNode);
    });
  }

  void closeSearch() {
    searchController.text = '';
    isSearchVisible = false;
    filterFunction('');
    setState(() {});
  }

  Widget buildSearchIcon() {
    return CommonIcon(
      isSearchVisible ? Icons.close_rounded : Icons.search_rounded,
      padding: EdgeInsets.all(16),
      onTap: openSearch,
    );
  }

  Widget buildFilledSearchIcon() {
    return CommonIcon(
      isSearchVisible ? Icons.close_rounded : Icons.search_rounded,
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(6),
      color: AppColors.light,
      backgroundColor: AppColors.secondary,
      onTap: openSearch,
    );
  }

  Widget buildSearchField({EdgeInsets? margin}) {
    return Visibility(
      visible: isSearchVisible,
      child: CommonTextField(
        margin: margin ?? EdgeInsets.all(16).copyWith(bottom: 0),
        controller: searchController,
        focusNode: searchFocusNode,
        isDense: true,
        hasLabel: false,
        hasBottomSpacing: false,
        hintText: AppTrKeys.search.tr(context),
        onChanged: filterList,
        hasSuffixBackground: false,
        suffixIcon: CommonIcon(
          Icons.backspace_rounded,
          onTap: () {
            searchController.clear();
            filterFunction('');
            setState(() {});
          },
        ),
      ),
    );
  }
}
