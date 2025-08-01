class CreateExpenseRequest {
  String? tenantCode;
  int? languageId;
  String? tenantCodeEncrypted;
  int? employeeId;
  String? ipAddress;
  int? companyId;
  int? incomeExpenseCategoryId;
  String? expenseTitle;
  String? expenseDescription;
  String? dateOfExpense;
  String? timeOfExpense;
  int? currencyId;
  String? totalExpenseAmount;
  int? isReimbursable;
  String? reimbursementNotes;

  CreateExpenseRequest({
    this.tenantCode,
    this.languageId,
    this.tenantCodeEncrypted,
    this.employeeId,
    this.ipAddress,
    this.companyId,
    this.incomeExpenseCategoryId,
    this.expenseTitle,
    this.expenseDescription,
    this.dateOfExpense,
    this.timeOfExpense,
    this.currencyId,
    this.totalExpenseAmount,
    this.isReimbursable,
    this.reimbursementNotes,
  });

  CreateExpenseRequest.fromJson(Map<String, dynamic> json) {
    tenantCode = json['tenant_code'];
    languageId = json['language_id'];
    tenantCodeEncrypted = json['tenant_code_encrypted'];
    employeeId = json['employee_id'];
    ipAddress = json['ip_address'];
    companyId = json['company_id'];
    incomeExpenseCategoryId = json['income_expense_category_id'];
    expenseTitle = json['expense_title'];
    expenseDescription = json['expense_description'];
    dateOfExpense = json['date_of_expense'];
    timeOfExpense = json['time_of_expense'];
    currencyId = json['currency_id'];
    totalExpenseAmount = json['total_expense_amount'];
    isReimbursable = json['is_reimbursable'];
    reimbursementNotes = json['reimbursement_notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenant_code'] = this.tenantCode;
    data['language_id'] = this.languageId;
    data['tenant_code_encrypted'] = this.tenantCodeEncrypted;
    data['employee_id'] = this.employeeId;
    data['ip_address'] = this.ipAddress;
    data['company_id'] = this.companyId;
    data['income_expense_category_id'] = this.incomeExpenseCategoryId;
    data['expense_title'] = this.expenseTitle;
    data['expense_description'] = this.expenseDescription;
    data['date_of_expense'] = this.dateOfExpense;
    data['time_of_expense'] = this.timeOfExpense;
    data['currency_id'] = this.currencyId;
    data['total_expense_amount'] = this.totalExpenseAmount;
    data['is_reimbursable'] = this.isReimbursable;
    data['reimbursement_notes'] = this.reimbursementNotes;
    return data;
  }

  CreateExpenseRequest copyWith({
    String? tenantCode,
    int? languageId,
    String? tenantCodeEncrypted,
    int? employeeId,
    String? ipAddress,
    int? companyId,
    int? incomeExpenseCategoryId,
    String? expenseTitle,
    String? expenseDescription,
    String? dateOfExpense,
    String? timeOfExpense,
    int? currencyId,
    String? totalExpenseAmount,
    int? isReimbursable,
    String? reimbursementNotes,
  }) {
    return CreateExpenseRequest(
      tenantCode: tenantCode ?? this.tenantCode,
      languageId: languageId ?? this.languageId,
      tenantCodeEncrypted: tenantCodeEncrypted ?? this.tenantCodeEncrypted,
      employeeId: employeeId ?? this.employeeId,
      ipAddress: ipAddress ?? this.ipAddress,
      companyId: companyId ?? this.companyId,
      incomeExpenseCategoryId: incomeExpenseCategoryId ?? this.incomeExpenseCategoryId,
      expenseTitle: expenseTitle ?? this.expenseTitle,
      expenseDescription: expenseDescription ?? this.expenseDescription,
      dateOfExpense: dateOfExpense ?? this.dateOfExpense,
      timeOfExpense: timeOfExpense ?? this.timeOfExpense,
      currencyId: currencyId ?? this.currencyId,
      totalExpenseAmount: totalExpenseAmount ?? this.totalExpenseAmount,
      isReimbursable: isReimbursable ?? this.isReimbursable,
      reimbursementNotes: reimbursementNotes ?? this.reimbursementNotes,
    );
  }
}
