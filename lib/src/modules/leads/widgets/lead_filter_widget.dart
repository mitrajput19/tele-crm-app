
import '../../../app/app.dart';

class LeadFilterWidget extends StatefulWidget {
  final Function(String?, String?, String?) onFilterApplied;

  const LeadFilterWidget({
    Key? key,
    required this.onFilterApplied,
  }) : super(key: key);

  @override
  State<LeadFilterWidget> createState() => _LeadFilterWidgetState();
}

class _LeadFilterWidgetState extends State<LeadFilterWidget> {
  String? _selectedStatus;
  String? _selectedAssignedTo;
  String? _selectedPriority;

  final List<String> _statusOptions = [
    'new',
    'contacted', 
    'qualified',
    'demo_scheduled',
    'demo_completed',
    'customer',
    'lost'
  ];

  final List<String> _priorityOptions = [
    'low',
    'medium',
    'high',
    'urgent'
  ];

  // This would normally come from your user management
  final List<String> _assignedToOptions = [
    'All Users',
    'John Doe',
    'Jane Smith',
    'Mike Johnson'
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Leads',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CommonDropdownField<String?>(
              getValueText: (value) => value?.replaceAll('_', ' ').toUpperCase() ?? '',
              value: _selectedStatus,
              items: _statusOptions,
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
              },
              label: 'Status',
            ),
            const SizedBox(height: 16),
            CommonDropdownField<String?>(
              getValueText: (value) => value?.replaceAll('_', ' ').toUpperCase() ?? '',
              value: _selectedPriority,
              items: _priorityOptions,
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value;
                });
              },
              label: 'Priority',
            ),
            const SizedBox(height: 16),
            CommonDropdownField<String?>(
              getValueText: (value) => value ?? '',
              value: _selectedAssignedTo,
              items: _assignedToOptions,
              onChanged: (value) {
                setState(() {
                  _selectedAssignedTo = value;
                });
              },
              label: 'Assigned To',
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: CommonOutlinedButton(
                    label: 'Clear Filters',
                    onPressed: _clearFilters,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CommonFilledButton(
                    label: 'Apply Filters',
                    onPressed: _applyFilters,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      _selectedStatus = null;
      _selectedAssignedTo = null;
      _selectedPriority = null;
    });
    widget.onFilterApplied(null, null, null);
    Navigator.of(context).pop();
  }

  void _applyFilters() {
    widget.onFilterApplied(_selectedStatus, _selectedAssignedTo, _selectedPriority);
    Navigator.of(context).pop();
  }
}
