import '../../../app/app.dart';
import '../../leads/bloc/leads_bloc.dart';

class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({super.key});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _alternateContactController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  final _schoolNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _quoteAmountController = TextEditingController();

  String? _selectedStatus;
  String? _selectedBoard;
  String? _selectedStandard;
  String? _selectedSource;
  String? _selectedDemoPerformedBy;

  final List<Map<String, String>> _statusOptions = [
    {"value": "demo_confirmed", "label": "Confirmed"},
    {"value": "demo_postponed", "label": "Postponed"},
    {"value": "demo_follow_up", "label": "Follow-up"},
    {"value": "not_interested", "label": "Not Interested"},
    {"value": "demo_done", "label": "Done"},
  ];

  final List<String> _boardOptions = [
    "Maharashtra Board English Medium",
    "Maharashtra State Board Semi Medium",
    "Maharashtra State Board Marathi Medium",
    "CBSE",
    "ICSE",
  ];

  final List<Map<String, String>> _standardOptions = [
    {"value": "1st", "label": "1st"},
    {"value": "2nd", "label": "2nd"},
    {"value": "3rd", "label": "3rd"},
    {"value": "4th", "label": "4th"},
    {"value": "5th", "label": "5th"},
    {"value": "6th", "label": "6th"},
    {"value": "7th", "label": "7th"},
    {"value": "8th", "label": "8th"},
    {"value": "9th", "label": "9th"},
    {"value": "10th", "label": "10th"},
    {"value": "11th", "label": "11th"},
    {"value": "12th", "label": "12th"},
  ];

  final List<Map<String, String>> _sourceOptions = [
    {"value": "Website", "label": "Website"},
    {"value": "Referral", "label": "Referral"},
    {"value": "Social Media", "label": "Social Media"},
    {"value": "Advertisement", "label": "Advertisement"},
    {"value": "Cold Call", "label": "Cold Call"},
    {"value": "Walk-in", "label": "Walk-in"},
    {"value": "Others", "label": "Others"},
  ];

  final List<Map<String, String>> _demoPerformedByOptions = [
    {"value": "Self", "label": "Self"},
    {"value": "Team Member", "label": "Team Member"},
    {"value": "External Trainer", "label": "External Trainer"},
    {"value": "Others", "label": "Others"},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _alternateContactController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveLead() {
    if (_formKey.currentState!.validate()) {
      context.read<LeadsBloc>().add(
        CreateLeadEvent(
          lead: Demo.fromJson({
            'student_name': _nameController.text,
            'board': _selectedBoard,
            'standard': _selectedStandard,
            'contact_no': _contactController.text,
            'alternate_contact_no': _alternateContactController.text,
            'demo_date': DateTime.now().toIso8601String(),
            'assigned_to': getIt<SupabaseService>().currentUserId,
            'status': _selectedStatus,
            'notes': _notesController.text,
            'created_by': getIt<SupabaseService>().currentUserId,
            'school_name': _schoolNameController.text,
            'city': _cityController.text,
            'address': _addressController.text,
            'source_of_lead': _selectedSource,
            'demo_performed_by': _selectedDemoPerformedBy,
            'quote_amount':   
                _quoteAmountController.text.isNotEmpty
                    ? double.tryParse(_quoteAmountController.text)
                    : null,
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          }),
        ),
      );
      context.showSnackBar(
        'Lead saved successfully!',
        type: SnackbarType.success,
      );
      context.pop();
      context.read<LeadsBloc>().add(LoadLeadsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Lead'),
        actions: [
          TextButton(
            onPressed: _saveLead,
            child: Text('Save', style: TextStyle(color: AppColors.secondary)),
          ),
        ],
      ),
      body: BlocConsumer<LeadsBloc, LeadsState>(
        listener: (context, state) {
          if (state is LeadsError) {
            context.showSnackBar(state.message, type: SnackbarType.danger);
          } else if (state is CreatedLeadSuccess) {
            context.showSnackBar('Lead created successfully!', type: SnackbarType.success);
            context.pop();
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                CommonTextField(
                  label: 'Student Name',
                  controller: _nameController,
                  validator: (value) => value?.isEmpty == true
                      ? 'Student Name is required'
                      : null,
                ),

                CommonTextField(
                  label: 'Contact Number',
                  controller: _contactController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value?.isEmpty == true)
                      return 'Contact number is required';
                    if (value!.length != 10)
                      return 'Contact number must be 10 digits';
                    return null;
                  },
                ),

                CommonTextField(
                  label: 'Alternate Contact Number',
                  controller: _alternateContactController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: (value) {
                    if (value?.isNotEmpty == true && value!.length != 10) {
                      return 'Alternate contact must be 10 digits';
                    }
                    return null;
                  },
                ),

                CommonTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value?.isNotEmpty == true && !value!.isValidEmail()) {
                      return 'Enter valid email';
                    }
                    return null;
                  },
                ),

                CommonTextField(
                  label: 'School Name',
                  controller: _schoolNameController,
                ),

                CommonDropdownField<String?>(
                  label: 'Status',
                  items: _statusOptions.map((e) => e['value']!).toList(),
                  value: _selectedStatus,
                  getValueText: (value) => value == null
                      ? 'Select Status'
                      : _statusOptions.firstWhere(
                          (e) => e['value'] == value,
                        )['label']!,
                  onChanged: (value) => setState(() => _selectedStatus = value),
                ),

                CommonDropdownField<String?>(
                  label: 'Board',
                  items: _boardOptions,
                  value: _selectedBoard,
                  getValueText: (value) => value ?? 'Select Board',
                  onChanged: (value) => setState(() => _selectedBoard = value),
                ),

                CommonDropdownField<String?>(
                  label: 'Standard',
                  items: _standardOptions.map((e) => e['value']!).toList(),
                  value: _selectedStandard,
                  getValueText: (value) => value == null
                      ? 'Select Standard'
                      : _standardOptions.firstWhere(
                          (e) => e['value'] == value,
                        )['label']!,
                  onChanged: (value) =>
                      setState(() => _selectedStandard = value),
                ),

                CommonDropdownField<String?>(
                  label: 'Source',
                  items: _sourceOptions.map((e) => e['value']!).toList(),
                  value: _selectedSource,
                  getValueText: (value) => value == null
                      ? 'Select Source'
                      : _sourceOptions.firstWhere(
                          (e) => e['value'] == value,
                        )['label']!,
                  onChanged: (value) => setState(() => _selectedSource = value),
                ),

                CommonDropdownField<String?>(
                  label: 'Demo Performed By',
                  items: _demoPerformedByOptions
                      .map((e) => e['value']!)
                      .toList(),
                  value: _selectedDemoPerformedBy,
                  getValueText: (value) => value == null
                      ? 'Select Demo Performer'
                      : _demoPerformedByOptions.firstWhere(
                          (e) => e['value'] == value,
                        )['label']!,
                  onChanged: (value) =>
                      setState(() => _selectedDemoPerformedBy = value),
                ),
                CommonTextField(label: 'City', controller: _cityController),

                CommonTextField(
                  label: 'Address',
                  controller: _addressController,
                  maxLines: 3,
                ),

                CommonTextField(
                  label: 'Quote Amount',
                  controller: _quoteAmountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),

                CommonTextField(
                  label: 'Notes',
                  controller: _notesController,
                  maxLines: 4,
                ),

                SizedBox(height: 32),
                CommonFilledButton(label: 'Save Lead', onPressed: _saveLead),
              ],
            ),
          );
        },
      ),
    );
  }
}
