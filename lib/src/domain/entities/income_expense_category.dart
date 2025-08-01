class IncomeExpenseCategory {
  int? incomeExpenseCategoryId;
  String? incomeExpenseCategoryName;
  String? incomeExpenseCategoryShortCode;
  String? incomeExpenseCategoryDescription;
  String? incomeExpenseCategoryColorCode;

  IncomeExpenseCategory({
    this.incomeExpenseCategoryId,
    this.incomeExpenseCategoryName,
    this.incomeExpenseCategoryShortCode,
    this.incomeExpenseCategoryDescription,
    this.incomeExpenseCategoryColorCode,
  });

  IncomeExpenseCategory.fromJson(Map<String, dynamic> json) {
    incomeExpenseCategoryId = json['income_expense_category_id'];
    incomeExpenseCategoryName = json['income_expense_category_name'];
    incomeExpenseCategoryShortCode = json['income_expense_category_short_code'];
    incomeExpenseCategoryDescription = json['income_expense_category_description'];
    incomeExpenseCategoryColorCode = json['income_expense_category_color_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['income_expense_category_id'] = this.incomeExpenseCategoryId;
    data['income_expense_category_name'] = this.incomeExpenseCategoryName;
    data['income_expense_category_short_code'] = this.incomeExpenseCategoryShortCode;
    data['income_expense_category_description'] = this.incomeExpenseCategoryDescription;
    data['income_expense_category_color_code'] = this.incomeExpenseCategoryColorCode;
    return data;
  }

  static List<IncomeExpenseCategory> listFromJson(dynamic json) {
    List<IncomeExpenseCategory> list = [];
    if (json['details']['income_expense_categories'] != null) {
      json['details']['income_expense_categories'].forEach((v) {
        list.add(new IncomeExpenseCategory.fromJson(v));
      });
    }
    return list;
  }
}
