import '../../app/app.dart';

class ExpenseApiServices {
  final NetworkServices services;
  ExpenseApiServices({required this.services});

  Future getIncomeExpenseCategoryList(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.getIncomeExpenseCategoryList,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }

  Future submitCreateExpense(Map<String, dynamic> data) async {
    var response = await services.post(
      path: AppUrls.submitCreateExpense,
      data: data,
    );
    return GenericResponse.fromJson(response);
  }
}
