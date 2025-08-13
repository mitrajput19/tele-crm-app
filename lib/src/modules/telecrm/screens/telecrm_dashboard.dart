import '../../../app/app.dart';

class TeleCRMDashboard extends StatefulWidget {
  const TeleCRMDashboard({super.key});

  @override
  State<TeleCRMDashboard> createState() => _TeleCRMDashboardState();
}

class _TeleCRMDashboardState extends State<TeleCRMDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    LeadsScreen(),
    CallRecordingsScreen(),
  ];

  final List<String> _titles = [
    'Leads',
    'Call History',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Leads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),

    );
  }

  Future<void> _syncCallRecordings() async {
    try {
      final callService = getIt<CallService>();
      final result = await callService.syncCallRecordings();
      
      showSnackbarBloc(
        'Sync completed: ${result['uploaded']} uploaded, ${result['failed']} failed',
        SnackbarType.success,
      );
      
      setState(() {}); // Refresh current screen
    } catch (e) {
      showSnackbarBloc('Sync failed: $e', SnackbarType.danger);
    }
  }
}