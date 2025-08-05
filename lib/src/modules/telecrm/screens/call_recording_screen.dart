
import 'package:flutter/material.dart';
import '../../../app/app.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No folder selected',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 24),
                    CommonFilledButton(
                      onPressed: _selectFolder,
                      text: 'Select folder',
                    ),
                  ],
                ),
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
            const SizedBox(height: 24),
            // Footer note
            Text(
              '*This feature is only available to devices which has inbuild call recordings feature.',
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
                  },
                  child: const Text('See recording uploads'),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Handle check compatibilities
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle refresh or sync
        },
        child: const Icon(Icons.sync),
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
          Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _selectFolder() {
    // TODO: Implement folder selection
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Recording Folder'),
        content: const Text('This feature will allow you to select a folder for storing call recordings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _selectedFolder = 'Call Recordings';
              });
            },
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }
}
