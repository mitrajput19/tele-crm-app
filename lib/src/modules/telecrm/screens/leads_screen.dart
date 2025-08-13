import '../../../app/app.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  List<Demo> leads = [];
  List<Demo> filteredLeads = [];
  bool isLoading = true;
  
  // Search and filter controllers
  final TextEditingController searchController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadLeads();
    searchController.addListener(_filterLeads);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _loadLeads() async {
    try {
      final supabaseService = getIt<SupabaseService>();
      final startDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
      final endDate = startDate.add(Duration(days: 1));
      
      final loadedLeads = await supabaseService.getLeads(
        startDate: startDate,
        endDate: endDate,
      );
      setState(() {
        leads = loadedLeads;
        filteredLeads = loadedLeads;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackbarBloc('Error loading leads: ${e.toString()}', SnackbarType.danger);
    }
  }

  void _filterLeads() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredLeads = leads.where((lead) {
        return lead.studentName.toLowerCase().contains(query) ||
               (lead.contactNo?.toLowerCase().contains(query) ?? false);
      }).toList();
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        isLoading = true;
      });
      _loadLeads();
    }
  }

  Future<void> _callLead(Demo lead) async {
    final phoneNumber = lead.contactNo ?? '';
    
    if (phoneNumber.isEmpty) {
      showSnackbarBloc('No phone number available for this lead', SnackbarType.warning);
      return;
    }
    
    try {
      final callService = getIt<CallService>();
      final success = await callService.makeDirectCall(phoneNumber);
      
      if (success) {
        showSnackbarBloc('Calling ${lead.studentName}...', SnackbarType.success);
      } else {
        showSnackbarBloc('Failed to make call', SnackbarType.danger);
      }
    } catch (e) {
      showSnackbarBloc('Error making call: ${e.toString()}', SnackbarType.danger);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leads'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: _selectDate,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => context.push(AppRoutes.addLead),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    controller: searchController,
                    hintText: 'Search by name or phone...',
                    hasLabel: false,
                    hasBottomSpacing: false,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    DateFormat('MMM dd').format(selectedDate),
                    style: Theme.of(context).textTheme.tsMedium12,
                  ),
                ),
              ],
            ),
          ),
          // Leads list
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredLeads.isEmpty
                    ? Center(
                        child: Text(
                          searchController.text.isNotEmpty 
                              ? 'No leads found matching "${searchController.text}"'
                              : 'No leads found for ${DateFormat('MMM dd, yyyy').format(selectedDate)}',
                          style: Theme.of(context).textTheme.tsGrayRegular16,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: filteredLeads.length,
                        itemBuilder: (context, index) {
                          final lead = filteredLeads[index];
                    return CommonCard(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lead.studentName,
                                      style: Theme.of(context).textTheme.tsMedium16,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      lead.contactNo ?? 'No phone',
                                      style: Theme.of(context).textTheme.tsGrayRegular14,
                                    ),
                                    if (lead.standard.isNotEmpty) ...[
                                      SizedBox(height: 2),
                                      Text(
                                        'Class: ${lead.standard}${lead.board != null ? ' (${lead.board})' : ''}',
                                        style: Theme.of(context).textTheme.tsGrayRegular12,
                                      ),
                                    ],
                                    SizedBox(height: 2),
                                    Text(
                                      'Demo: ${DateFormat('MMM dd, yyyy').format(lead.demoDate)}',
                                      style: Theme.of(context).textTheme.tsGrayRegular12,
                                    ),
                                  ],
                                ),
                              ),
                              CommonIcon(
                                Icons.call,
                                backgroundColor: AppColors.success,
                                color: AppColors.light,
                                onTap: () => _callLead(lead),
                              ),
                            ],
                          ),
                          if (lead.city?.isNotEmpty == true || lead.schoolName?.isNotEmpty == true) ...[
                            SizedBox(height: 4),
                            Text(
                              [lead.schoolName, lead.city].where((s) => s?.isNotEmpty == true).join(', '),
                              style: Theme.of(context).textTheme.tsGrayRegular12,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          if (lead.notes?.isNotEmpty == true) ...[
                            SizedBox(height: 8),
                            Text(
                              lead.notes!,
                              style: Theme.of(context).textTheme.tsRegular14,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  void _showAddLeadDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final alternatePhoneController = TextEditingController();
    final standardController = TextEditingController();
    final boardController = TextEditingController();
    final schoolController = TextEditingController();
    final cityController = TextEditingController();
    final addressController = TextEditingController();
    final sourceController = TextEditingController();
    final notesController = TextEditingController();
    DateTime selectedDemoDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Add New Lead'),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonTextField(
                    controller: nameController,
                    label: 'Student Name *',
                    hintText: 'Enter student name',
                  ),
                  CommonTextField(
                    controller: phoneController,
                    label: 'Contact Number *',
                    hintText: 'Enter contact number',
                    keyboardType: TextInputType.phone,
                  ),
                  CommonTextField(
                    controller: alternatePhoneController,
                    label: 'Alternate Contact',
                    hintText: 'Enter alternate contact',
                    keyboardType: TextInputType.phone,
                  ),
                  CommonTextField(
                    controller: standardController,
                    label: 'Standard/Class *',
                    hintText: 'Enter standard/class',
                  ),
                  CommonTextField(
                    controller: boardController,
                    label: 'Board',
                    hintText: 'Enter board (CBSE, ICSE, etc.)',
                  ),
                  CommonTextField(
                    controller: schoolController,
                    label: 'School Name',
                    hintText: 'Enter school name',
                  ),
                  CommonTextField(
                    controller: cityController,
                    label: 'City',
                    hintText: 'Enter city',
                  ),
                  CommonTextField(
                    controller: addressController,
                    label: 'Address',
                    hintText: 'Enter address',
                    maxLines: 2,
                  ),
                  CommonTextField(
                    controller: sourceController,
                    label: 'Source of Lead',
                    hintText: 'Enter source (Website, Referral, etc.)',
                  ),
                  // Demo Date Picker
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Demo Date *',
                          style: Theme.of(context).textTheme.tsMedium14,
                        ),
                        SizedBox(height: 8),
                        InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDemoDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                            );
                            if (picked != null) {
                              setDialogState(() {
                                selectedDemoDate = picked;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.gray.withValues(alpha: 0.25)),
                              borderRadius: BorderRadius.circular(AppTheme.textFieldBorderRadius),
                              color: Theme.of(context).cardColor,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today, size: 20),
                                SizedBox(width: 12),
                                Text(
                                  DateFormat('MMM dd, yyyy').format(selectedDemoDate),
                                  style: Theme.of(context).textTheme.tsRegular14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CommonTextField(
                    controller: notesController,
                    label: 'Notes',
                    hintText: 'Enter any additional notes',
                    maxLines: 3,
                    hasBottomSpacing: false,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => _addLead(
                name: nameController.text,
                phone: phoneController.text,
                alternatePhone: alternatePhoneController.text,
                standard: standardController.text,
                board: boardController.text,
                school: schoolController.text,
                city: cityController.text,
                address: addressController.text,
                source: sourceController.text,
                notes: notesController.text,
                demoDate: selectedDemoDate,
              ),
              child: Text('Add Lead'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addLead({
    required String name,
    required String phone,
    required String standard,
    required DateTime demoDate,
    String? alternatePhone,
    String? board,
    String? school,
    String? city,
    String? address,
    String? source,
    String? notes,
  }) async {
    if (name.isEmpty || phone.isEmpty || standard.isEmpty) {
      showSnackbarBloc('Name, phone, and standard are required', SnackbarType.warning);
      return;
    }

    try {
      final supabaseService = getIt<SupabaseService>();
      final newLead = Demo(
        id: '',
        studentName: name,
        contactNo: phone,
        alternateContactNo: alternatePhone?.isNotEmpty == true ? alternatePhone : null,
        standard: standard,
        board: board?.isNotEmpty == true ? board : null,
        schoolName: school?.isNotEmpty == true ? school : null,
        city: city?.isNotEmpty == true ? city : null,
        address: address?.isNotEmpty == true ? address : null,
        sourceOfLead: source?.isNotEmpty == true ? source : null,
        notes: notes?.isNotEmpty == true ? notes : null,
        demoDate: demoDate,
        status: 'new',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      
      Navigator.pop(context);
      _loadLeads();
      showSnackbarBloc('Lead added successfully', SnackbarType.success);
    } catch (e) {
      showSnackbarBloc('Error adding lead: ${e.toString()}', SnackbarType.danger);
    }
  }
}