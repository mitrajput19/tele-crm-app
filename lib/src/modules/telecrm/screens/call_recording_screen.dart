
import 'package:flutter/material.dart';
import '../../../app/app.dart';
import '../widgets/call_recording_sync_widget.dart';

class CallRecordingScreen extends StatefulWidget {
  const CallRecordingScreen({super.key});

  @override
  State<CallRecordingScreen> createState() => _CallRecordingScreenState();
}

class _CallRecordingScreenState extends State<CallRecordingScreen> {
  String? _selectedFolder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call Recording'),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  // Navigate to notifications
                },
                icon: const Icon(Icons.notifications_outlined),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '99+',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Call Recording Sync Section
            const CallRecordingSyncWidget(),
            
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            
            // Recording's Folder Section
            const Text(
              "Recording's Folder",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            // Folder selection area
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _selectedFolder != null 
                        ? Icons.folder 
                        : Icons.folder_outlined,
                    size: 80,
                    color: _selectedFolder != null 
                        ? Colors.blue 
                        : Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _selectedFolder ?? 'Auto-detected call recordings folder',
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedFolder != null 
                          ? Colors.blue 
                          : Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  CommonFilledButton(
                    onPressed: _selectFolder,
                    label: 'Change folder',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Troubleshoot section
            Row(
              children: [
                const Text(
                  'Troubleshoot Call Recording Sync',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.orange[400],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Troubleshoot items
            _buildTroubleshootItem('Turn off WiFi calling'),
            _buildTroubleshootItem('Add call recording folder again'),
            _buildTroubleshootItem('Disable Truecaller as default Dialer app'),
            _buildTroubleshootItem('Check you have good internet connection'),
            _buildTroubleshootItem('Grant storage permissions for the app'),
            _buildTroubleshootItem('Ensure call recording is enabled on device'),
            const SizedBox(height: 24),
            // Footer note
            Text(
              '*This feature automatically detects and syncs call recordings from your device. Ensure call recording is enabled in your phone settings.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            // Action buttons
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    // Handle see recording uploads
                    _showUploadHistory();
                  },
                  child: const Text('See recording uploads'),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Handle check compatibilities
                    _showCompatibilityInfo();
                  },
                  child: const Text('Check compatibilities'),
                ),
                const Icon(
                  Icons.open_in_new,
                  size: 16,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTroubleshootItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 6,
            color: Colors.black,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _selectFolder() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recording Folder'),
        content: const Text(
          'The app automatically detects call recordings from common locations on your device. '
          'If recordings are not being detected, ensure:\n\n'
          '• Call recording is enabled in phone settings\n'
          '• Storage permissions are granted\n'
          '• Recordings are saved in a standard location'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showUploadHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upload History'),
        content: const SizedBox(
          width: double.maxFinite,
          height: 300,
          child: Center(
            child: Text('Upload history will be displayed here'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCompatibilityInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Device Compatibility'),
        content: const Text(
          'Call recording sync is compatible with:\n\n'
          '• Android devices with built-in call recording\n'
          '• Samsung, Xiaomi, OnePlus, and other OEM dialers\n'
          '• Third-party recording apps that save to standard locations\n\n'
          'Note: Some devices may require enabling call recording in system settings.'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
