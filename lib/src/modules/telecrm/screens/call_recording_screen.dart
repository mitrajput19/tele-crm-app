
import 'dart:io';
import 'package:file_picker/file_picker.dart';
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
  List<File> localRecordings = [];
  bool isLoadingRecordings = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentPath();
  }

  Future<void> _loadCurrentPath() async {
    try {
      final settings = await getIt<SupabaseService>().getUserSettings();
      if (settings?.callRecordingPath != null) {
        setState(() {
          _selectedFolder = settings!.callRecordingPath!;
        });
        _loadLocalRecordings();
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _loadLocalRecordings() async {
    if (_selectedFolder == null) return;
    
    setState(() {
      isLoadingRecordings = true;
    });
    
    try {
      final directory = Directory(_selectedFolder!);
      if (await directory.exists()) {
        final files = await directory
            .list()
            .where((file) => file is File && _isAudioFile(file.path))
            .cast<File>()
            .toList();
        
        setState(() {
          localRecordings = files;
          isLoadingRecordings = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoadingRecordings = false;
      });
      showSnackbarBloc('Error loading recordings: $e', SnackbarType.danger);
    }
  }

  bool _isAudioFile(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    return ['mp3', 'wav', 'm4a', 'aac', 'amr', '3gp'].contains(extension);
  }

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
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(
                          _selectedFolder != null 
                              ? Icons.folder 
                              : Icons.folder_outlined,
                          size: 60,
                          color: _selectedFolder != null 
                              ? Colors.blue 
                              : Colors.grey[400],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _selectedFolder ?? 'Auto-detected call recordings folder',
                          style: TextStyle(
                            fontSize: 14,
                            color: _selectedFolder != null 
                                ? Colors.blue 
                                : Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),
                        CommonButton(
                          onPressed: _selectFolder,
                          label: 'Change folder',
                          height: 36,
                        ),
                      ],
                    ),
                  ),
                  if (_selectedFolder != null) ...[
                    const Divider(height: 1),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Local Recordings (${localRecordings.length})',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              if (isLoadingRecordings)
                                const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              else
                                IconButton(
                                  onPressed: _loadLocalRecordings,
                                  icon: const Icon(Icons.refresh, size: 18),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (localRecordings.isEmpty && !isLoadingRecordings)
                            const Text(
                              'No recordings found in this folder',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            )
                          else
                            ...localRecordings.take(3).map((file) => _buildRecordingItem(file)),
                          if (localRecordings.length > 3)
                            TextButton(
                              onPressed: _showAllRecordings,
                              child: Text('View all ${localRecordings.length} recordings'),
                            ),
                        ],
                      ),
                    ),
                  ],
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

  Widget _buildRecordingItem(File file) {
    final fileName = file.path.split('/').last;
    final fileStat = file.statSync();
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.audiotrack, size: 16, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${(fileStat.size / 1024 / 1024).toStringAsFixed(1)} MB • ${DateFormat('MMM dd').format(fileStat.modified)}',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectFolder() {
    showDialog(
      context: context,
      builder: (context) => _RecordingPathDialog(
        onPathChanged: (newPath) {
          setState(() {
            _selectedFolder = newPath;
          });
          _loadLocalRecordings();
        },
      ),
    );
  }

  void _showAllRecordings() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: double.maxFinite,
          height: 400,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Local Recordings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: localRecordings.length,
                  itemBuilder: (context, index) {
                    final file = localRecordings[index];
                    return _buildRecordingItem(file);
                  },
                ),
              ),
            ],
          ),
        ),
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

class _RecordingPathDialog extends StatefulWidget {
  final Function(String)? onPathChanged;
  
  const _RecordingPathDialog({this.onPathChanged});
  
  @override
  _RecordingPathDialogState createState() => _RecordingPathDialogState();
}

class _RecordingPathDialogState extends State<_RecordingPathDialog> {
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
      title: const Text('Set Call Recording Path'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Enter the path where your device stores call recordings:',
          ),
          const SizedBox(height: 16),
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
              const SizedBox(width: 8),
              CommonButton(
                label: 'Browse',
                height: 40,
                width: 80,
                onPressed: _selectFolder,
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap Browse to select folder or enter path manually',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        CommonButton(
          label: 'Save',
          isLoading: _isLoading,
          onPressed: _savePath,
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
      widget.onPathChanged?.call(_pathController.text.trim());
      showSnackbarBloc('Recording path updated successfully', SnackbarType.success);
    } catch (e) {
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