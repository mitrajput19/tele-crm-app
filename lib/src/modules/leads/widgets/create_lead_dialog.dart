
import '../../../app/app.dart';

class CreateLeadDialog extends StatefulWidget {
  final Function(Demo) onLeadCreated;

  const CreateLeadDialog({
    Key? key,
    required this.onLeadCreated,
  }) : super(key: key);

  @override
  State<CreateLeadDialog> createState() => _CreateLeadDialogState();
}

class _CreateLeadDialogState extends State<CreateLeadDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _alternatePhoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedStatus = 'new';
  String _selectedPriority = 'medium';
  String _selectedSource = 'website';
  String _selectedStage = 'Fresh Lead';

  final List<String> _statusOptions = ['new', 'contacted', 'qualified', 'demo_scheduled', 'demo_completed', 'customer', 'lost'];
  final List<String> _priorityOptions = ['low', 'medium', 'high', 'urgent'];
  final List<String> _sourceOptions = ['website', 'referral', 'cold_call', 'marketing', 'social_media'];
  final List<String> _stageOptions = ['Fresh Lead', 'Contacted', 'Qualified', 'Demo Scheduled', 'Proposal Sent', 'Negotiation'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _alternatePhoneController.dispose();
    _companyController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Create New Lead',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CommonTextField(
                        controller: _nameController,
                        hintText: 'Student Name',
                        labelText: 'Student Name *',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter student name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CommonTextField(
                        controller: _emailController,
                        hintText: 'Email Address',
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CommonTextField(
                        controller: _phoneController,
                        hintText: 'Phone Number',
                        labelText: 'Phone Number *',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CommonTextField(
                        controller: _alternatePhoneController,
                        hintText: 'Alternate Phone',
                        labelText: 'Alternate Phone',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      CommonTextField(
                        controller: _companyController,
                        hintText: 'Company/Organization',
                        labelText: 'Company',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CommonDropDownField<String>(
                              value: _selectedStatus,
                              items: _statusOptions.map((status) {
                                return DropdownMenuItem(
                                  value: status,
                                  child: Text(status.replaceAll('_', ' ').toUpperCase()),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedStatus = value!;
                                });
                              },
                              labelText: 'Status',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CommonDropDownField<String>(
                              value: _selectedPriority,
                              items: _priorityOptions.map((priority) {
                                return DropdownMenuItem(
                                  value: priority,
                                  child: Text(priority.toUpperCase()),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedPriority = value!;
                                });
                              },
                              labelText: 'Priority',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CommonDropDownField<String>(
                              value: _selectedSource,
                              items: _sourceOptions.map((source) {
                                return DropdownMenuItem(
                                  value: source,
                                  child: Text(source.replaceAll('_', ' ').toUpperCase()),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedSource = value!;
                                });
                              },
                              labelText: 'Source',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CommonDropDownField<String>(
                              value: _selectedStage,
                              items: _stageOptions.map((stage) {
                                return DropdownMenuItem(
                                  value: stage,
                                  child: Text(stage),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedStage = value!;
                                });
                              },
                              labelText: 'Stage',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CommonTextField(
                        controller: _notesController,
                        hintText: 'Notes',
                        labelText: 'Notes',
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonTextButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 12),
                CommonFilledButton(
                  text: 'Create Lead',
                  onPressed: _createLead,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _createLead() {
    if (_formKey.currentState!.validate()) {
      final lead = Demo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        studentName: _nameController.text.trim(),
        contactNo: _phoneController.text.trim(),
        alternateContactNo: _alternatePhoneController.text.trim().isEmpty 
            ? null 
            : _alternatePhoneController.text.trim(),
        email: _emailController.text.trim().isEmpty 
            ? null 
            : _emailController.text.trim(),
        college: _companyController.text.trim().isEmpty 
            ? null 
            : _companyController.text.trim(),
        status: _selectedStatus,
        priority: _selectedPriority,
        source: _selectedSource,
        stage: _selectedStage,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        notes: _notesController.text.trim().isEmpty 
            ? null 
            : _notesController.text.trim(),
      );

      widget.onLeadCreated(lead);
      Navigator.of(context).pop();
    }
  }
}
