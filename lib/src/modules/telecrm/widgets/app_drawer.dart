import 'package:file_picker/file_picker.dart';

import '../../../app/app.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      child: Column(
        children: [
          // Header
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.lightPrimary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.light,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: AppColors.lightPrimary,
                      ),
                    ),
                    SizedBox(height: 12),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final user = getIt<SupabaseService>().currentUser;
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.userMetadata?['full_name'] ?? 'User',
                              style: Theme.of(context).textTheme.tsLightSemiBold16,
                            ),
                            Text(
                              user?.email ?? '',
                              style: Theme.of(context).textTheme.tsLightRegular12,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () {
                    Navigator.pop(context);
                   
                  },
                ),
                _DrawerItem(
                  icon: Icons.people,
                  title: 'Leads',
                  onTap: () {
                    Navigator.pop(context);
                    context.push(AppRoutes.leads);
                  },
                ),
                _DrawerItem(
                  icon: Icons.person_add,
                  title: 'Add Lead',
                  onTap: () {
                    Navigator.pop(context);
                    context.push(AppRoutes.addLead);
                  },
                ),
                _DrawerItem(
                  icon: Icons.call,
                  title: 'Call Recordings',
                  onTap: () {
                    Navigator.pop(context);
                    context.push(AppRoutes.callRecording);
                  },
                ),
                _DrawerItem(
                  icon: Icons.history,
                  title: 'Call History',
                  onTap: () {
                    Navigator.pop(context);
                    context.push(AppRoutes.callHistory);
                  },
                ),

                CommonDivider(),
                _DrawerItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    context.push(AppRoutes.settings);
                  },
                ),
                _DrawerItem(
                  icon: Icons.folder_open,
                  title: 'Recording Path Settings',
                  onTap: () {
                    Navigator.pop(context);
                    _showRecordingPathDialog(context);
                  },
                ),
                _DrawerItem(
                  icon: Icons.info_outline,
                  title: 'About',
                  onTap: () {
                    Navigator.pop(context);
                    _showAboutDialog(context);
                  },
                ),
              ],
            ),
          ),
          
          // Sign Out
          Container(
            padding: EdgeInsets.all(16),
            child: CommonButton(
              label: 'Sign Out',
              backgroundColor: AppColors.danger,
              onPressed: () => _signOut(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: AppColors.light, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Sign Out',
                    style: Theme.of(context).textTheme.tsLightMedium14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signOut(BuildContext context) {
    CommonAwesomeDialog.show(
      context: context,
      title: 'Sign Out',
      description: 'Are you sure you want to sign out?',
      onConfirmPressed: () async {
        try {
          await getIt<SupabaseService>().signOut();
          context.go(AppRoutes.login);
        } catch (e) {
          showSnackbarBloc('Failed to sign out', SnackbarType.danger);
        }
      },
    );
  }

  void _showRecordingPathDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => RecordingPathDialog(),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          'About TeleCRM',
          style: Theme.of(context).textTheme.tsSemiBold18,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version: 1.0.0',
              style: Theme.of(context).textTheme.tsRegular14,
            ),
            SizedBox(height: 8),
            Text(
              'A comprehensive CRM solution for telecalling teams.',
              style: Theme.of(context).textTheme.tsRegular14,
            ),
            SizedBox(height: 8),
            Text(
              '© 2024 Home Revise',
              style: Theme.of(context).textTheme.tsRegular14,
            ),
          ],
        ),
        actions: [
          CommonTextButton(
            onPressed: () => Navigator.pop(context),
            label: 'Close',
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(
        title,
        style: Theme.of(context).textTheme.tsMedium14,
      ),
      onTap: onTap,
    );
  }
}

class RecordingPathDialog extends StatefulWidget {
  @override
  _RecordingPathDialogState createState() => _RecordingPathDialogState();
}

class _RecordingPathDialogState extends State<RecordingPathDialog> {
  final TextEditingController _pathController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentPath();
  }

  void _loadCurrentPath() async {
    try {
      final settings = await getIt<SupabaseService>().getUserSettings();
      if (settings?.callRecordingPath != null) {
        _pathController.text = settings!.callRecordingPath!;
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Text(
        'Set Call Recording Path',
        style: Theme.of(context).textTheme.tsSemiBold18,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter the path where your device stores call recordings:',
            style: Theme.of(context).textTheme.tsRegular14,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CommonTextField(
                  controller: _pathController,
                  label: 'Recording Path',
                  hintText: '/storage/emulated/0/Call recordings',
                  maxLines: 2,
                ),
              ),
              SizedBox(width: 8),
              CommonButton(
                label: 'Browse',
                height: 40,
                width: 80,
                onPressed: _selectFolder,
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Tap Browse to select folder or enter path manually',
            style: Theme.of(context).textTheme.tsGrayRegular12,
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: CommonTextButton(
                  onPressed: () => Navigator.pop(context),
                  label: 'Cancel',
                ),
              ),
              SizedBox(width: 12),
              Flexible(
                child: CommonButton(
                  label: 'Save',
                  backgroundColor: Theme.of(context).primaryColor,
                  isLoading: _isLoading,
                  onPressed: _savePath,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _selectFolder() async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory != null) {
        _pathController.text = selectedDirectory;
      }
    } catch (e) {
      showSnackbarBloc('Failed to select folder', SnackbarType.danger);
    }
  }

  void _savePath() async {
    if (_pathController.text.trim().isEmpty) {
      showSnackbarBloc('Please enter a valid path', SnackbarType.warning);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await getIt<SupabaseService>().updateUserSettings(
        callRecordingPath: _pathController.text.trim(),
      );
      
      Navigator.pop(context);
      showSnackbarBloc('Recording path updated successfully', SnackbarType.success);
    } catch (e) {
      log(e.toString(), name: 'RecordingPathDialog');
      showSnackbarBloc('Failed to update path', SnackbarType.danger);
    } finally {
      
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _pathController.dispose();
    super.dispose();
  }
}