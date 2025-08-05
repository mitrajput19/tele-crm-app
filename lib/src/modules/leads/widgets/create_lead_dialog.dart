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
  final _studentNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _alternateContactController = TextEditingController();
  final _schoolNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _quoteAmountController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedBoard;
  String? _selectedStandard;
  String? _selectedSourceOfLead;
  DateTime? _selectedDemoDateTime;
  String? _selectedStatus;
  String? _selectedAssignTo;
  String? _selectedDemoPerformedBy;

  // Sample data - replace with your actual data
  final List<String> _boardOptions = ['CBSE', 'ICSE', 'State Board', 'IB', 'IGCSE'];
  final List<String> _standardOptions = ['1st', '2nd', '3rd', '4th', '5th', '6th', '7th', '8th', '9th', '10th', '11th', '12th'];
  final List<String> _sourceOptions = ['Website', 'Referral', 'Cold Call', 'Marketing', 'Social Media', 'Walk-in'];
  final List<String> _statusOptions = ['Confirmed', 'Pending', 'Cancelled', 'Completed'];
  final List<String> _assignToOptions = ['Me', 'John Doe', 'Jane Smith', 'Mike Johnson'];
  final List<String> _demoPerformerOptions = ['John Doe', 'Jane Smith', 'Mike Johnson', 'Sarah Wilson'];

  @override
  void initState() {
    super.initState();
    // Set default values if needed
    _selectedStatus = 'Confirmed';
    _selectedAssignTo = 'Me';
  }

  @override
  void dispose() {
    _studentNameController.dispose();
    _contactNumberController.dispose();
    _alternateContactController.dispose();
    _schoolNameController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _quoteAmountController.dispose();
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
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Create Demo',
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
                      // Row 1: Student Name and Contact Number
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              controller: _studentNameController,
                              hintText: 'Rahul Sharma',
                              label: 'Student Name *',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter student name';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CommonTextField(
                              controller: _contactNumberController,
                              hintText: '9123456789',
                              label: 'Contact Number *',
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter contact number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Row 2: Alternate Contact and Board
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              controller: _alternateContactController,
                              hintText: '9123456789',
                              label: 'Alternate Contact',
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CommonDropdownField<String?>(
                              getValueText: (value) => value ?? '',
                              value: _selectedBoard,
                              items: _boardOptions,
                              onChanged: (value) {
                                setState(() {
                                  _selectedBoard = value;
                                });
                              },
                              label: 'Board *',
                              hintText: 'Select board',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select board';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Row 3: Standard and School Name
                      Row(
                        children: [
                          Expanded(
                            child: CommonDropdownField<String?>(
                              getValueText: (value) => value ?? '',
                              value: _selectedStandard,
                              items: _standardOptions,
                              onChanged: (value) {
                                setState(() {
                                  _selectedStandard = value;
                                });
                              },
                              label: 'Standard *',
                              hintText: 'Select standard',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select standard';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CommonTextField(
                              controller: _schoolNameController,
                              hintText: 'Mumbai Public School',
                              label: 'School Name *',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter school name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Row 4: City (full width)
                      CommonTextField(
                        controller: _cityController,
                        hintText: 'Mumbai',
                        label: 'City *',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter city';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      // Row 5: Address (full width)
                      CommonTextField(
                        controller: _addressController,
                        hintText: '123, Main Street, Mumbai',
                        label: 'Address',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 16),
                      
                      // Row 6: Source of Lead (full width)
                      CommonDropdownField<String?>(
                        getValueText: (value) => value ?? '',
                        value: _selectedSourceOfLead,
                        items: _sourceOptions,
                        onChanged: (value) {
                          setState(() {
                            _selectedSourceOfLead = value;
                          });
                        },
                        label: 'Source of Lead *',
                        hintText: 'Select source',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select source of lead';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      // Row 7: Demo Date & Time and Status
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: _selectDateTime,
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  labelText: 'Demo Date & Time *',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                child: Text(
                                  _selectedDemoDateTime != null
                                      ? '${_selectedDemoDateTime!.day}/${_selectedDemoDateTime!.month}/${_selectedDemoDateTime!.year} ${_selectedDemoDateTime!.hour}:${_selectedDemoDateTime!.minute.toString().padLeft(2, '0')}'
                                      : 'Select date and time',
                                  style: TextStyle(
                                    color: _selectedDemoDateTime != null
                                        ? Theme.of(context).textTheme.bodyLarge?.color
                                        : Theme.of(context).hintColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CommonDropdownField<String?>(
                              getValueText: (value) => value ?? '',
                              value: _selectedStatus,
                              items: _statusOptions,
                              onChanged: (value) {
                                setState(() {
                                  _selectedStatus = value;
                                });
                              },
                              label: 'Status *',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select status';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Row 8: Assign To and Demo Performed By
                      Row(
                        children: [
                          Expanded(
                            child: CommonDropdownField<String?>(
                              getValueText: (value) => value ?? '',
                              value: _selectedAssignTo,
                              items: _assignToOptions,
                              onChanged: (value) {
                                setState(() {
                                  _selectedAssignTo = value;
                                });
                              },
                              label: 'Assign To *',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select assignee';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CommonDropdownField<String?>(
                              getValueText: (value) => value ?? '',
                              value: _selectedDemoPerformedBy,
                              items: _demoPerformerOptions,
                              onChanged: (value) {
                                setState(() {
                                  _selectedDemoPerformedBy = value;
                                });
                              },
                              label: 'Demo Performed By',
                              hintText: 'Select performer',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Row 9: Quote Amount (full width)
                      CommonTextField(
                        controller: _quoteAmountController,
                        hintText: 'Enter quote amount if applicable',
                        label: 'Quote Amount (₹) (Optional)',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      
                      // Row 10: Notes (full width)
                      CommonTextField(
                        controller: _notesController,
                        hintText: 'Any additional notes...',
                        label: 'Notes',
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
                  label: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 12),
                CommonFilledButton(
                  label: 'Create Demo',
                  onPressed: _createDemo,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      
      if (time != null) {
        setState(() {
          _selectedDemoDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _createDemo() {
    // Validate required fields
    bool isValid = _formKey.currentState!.validate();
    
    if (_selectedDemoDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select demo date and time')),
      );
      isValid = false;
    }

    if (isValid) {
      final lead = Demo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        studentName: _studentNameController.text.trim(),
        contactNo: _contactNumberController.text.trim(),
        alternateContactNo: _alternateContactController.text.trim().isEmpty 
            ? null 
            : _alternateContactController.text.trim(),
        schoolName: _schoolNameController.text.trim(),
        standard: _selectedStandard ?? '',
        demoDate: _selectedDemoDateTime ?? DateTime.now(),
        status: _selectedStatus ?? '',
        sourceOfLead: _selectedSourceOfLead ?? '',
        demoPerformedBy: _selectedDemoPerformedBy ?? '',
        quoteAmount: _quoteAmountController.text.trim().isEmpty 
            ? null 
            : double.tryParse(_quoteAmountController.text.trim()),
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