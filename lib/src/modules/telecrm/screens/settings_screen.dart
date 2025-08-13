import '../../../app/app.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserSettings? userSettings;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    try {
      final settings = await getIt<SupabaseService>().getUserSettings();
      setState(() {
        userSettings = settings;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.all(16),
              children: [
                CommonCard(
                  hasLabel: true,
                  label: 'Call Recording Settings',
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.folder_open),
                        title: Text('Recording Path'),
                        subtitle: Text(
                          userSettings?.callRecordingPath ?? 'Not set',
                          style: Theme.of(context).textTheme.tsGrayRegular12,
                        ),
                        trailing: Icon(Icons.chevron_right),
                        onTap: _showRecordingPathDialog,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                CommonCard(
                  hasLabel: true,
                  label: 'Device Information',
                  child: Column(
                    children: [
                      _buildInfoTile('Device Model', userSettings?.deviceModel ?? 'Unknown'),
                      _buildInfoTile('Device Brand', userSettings?.deviceBrand ?? 'Unknown'),
                      _buildInfoTile('OS Version', userSettings?.osVersion ?? 'Unknown'),
                      _buildInfoTile('App Version', userSettings?.appVersion ?? '1.0.0'),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                CommonCard(
                  hasLabel: true,
                  label: 'App Settings',
                  child: Column(
                    children: [
                      BlocBuilder<AppBloc, AppState>(
                        builder: (context, state) {
                          return SwitchListTile(
                            title: Text('Dark Mode'),
                            subtitle: Text('Enable dark theme'),
                            value: context.isDarkMode,
                            onChanged: (value) {
                              context.read<AppBloc>().add(AppThemeToggleEvent(value));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        value,
        style: Theme.of(context).textTheme.tsGrayRegular12,
      ),
    );
  }

  void _showRecordingPathDialog() {
    showDialog(
      context: context,
      builder: (context) => RecordingPathDialog(),
    ).then((_) => _loadSettings());
  }
}