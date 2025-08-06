
import 'package:flutter/material.dart';
import '../../../core/core.dart';
import '../../../data/services/call_recording_service.dart';

class CallRecordingSyncWidget extends StatefulWidget {
  const CallRecordingSyncWidget({super.key});

  @override
  State<CallRecordingSyncWidget> createState() => _CallRecordingSyncWidgetState();
}

class _CallRecordingSyncWidgetState extends State<CallRecordingSyncWidget> {
  final CallRecordingService _recordingService = CallRecordingService();
  bool _isLoading = false;
  bool _isMonitoring = false;
  Map<String, int> _syncStats = {};
  List<String> _pendingRecordings = [];

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  Future<void> _initializeService() async {
    setState(() => _isLoading = true);
    
    try {
      final initialized = await _recordingService.initialize();
      if (initialized) {
        await _loadSyncStats();
        await _loadPendingRecordings();
      } else {
        _showSnackBar('Failed to initialize call recording service', isError: true);
      }
    } catch (e) {
      _showSnackBar('Error initializing: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadSyncStats() async {
    try {
      final stats = await _recordingService.getSyncStats();
      setState(() => _syncStats = stats);
    } catch (e) {
      _showSnackBar('Error loading stats: $e', isError: true);
    }
  }

  Future<void> _loadPendingRecordings() async {
    try {
      final recordings = await _recordingService.getAllRecordings();
      setState(() => _pendingRecordings = recordings);
    } catch (e) {
      _showSnackBar('Error loading recordings: $e', isError: true);
    }
  }

  Future<void> _startAutoMonitoring() async {
    setState(() => _isMonitoring = true);
    
    try {
      while (_isMonitoring) {
        final newRecordings = await _recordingService.monitorNewRecordings();
        
        if (newRecordings.isNotEmpty) {
          _showSnackBar('Found ${newRecordings.length} new recordings');
          
          for (final recording in newRecordings) {
            final success = await _recordingService.syncRecording(recording);
            if (success) {
              _showSnackBar('Auto-synced: ${recording.split('/').last}');
            }
          }
          
          await _loadSyncStats();
          await _loadPendingRecordings();
        }
        
        // Check every 30 seconds
        await Future.delayed(const Duration(seconds: 30));
      }
    } catch (e) {
      _showSnackBar('Error in auto monitoring: $e', isError: true);
    }
  }

  void _stopAutoMonitoring() {
    setState(() => _isMonitoring = false);
  }

  Future<void> _syncAllRecordings() async {
    if (_pendingRecordings.isEmpty) {
      _showSnackBar('No recordings to sync');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final results = await _recordingService.syncMultipleRecordings(_pendingRecordings);
      
      final successCount = results.values.where((success) => success).length;
      final failCount = results.length - successCount;
      
      _showSnackBar(
        'Sync completed: $successCount successful, $failCount failed',
        isError: failCount > 0,
      );
      
      await _loadSyncStats();
      await _loadPendingRecordings();
    } catch (e) {
      _showSnackBar('Error syncing recordings: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _syncSingleRecording(String filePath) async {
    setState(() => _isLoading = true);

    try {
      final success = await _recordingService.syncRecording(filePath);
      
      if (success) {
        _showSnackBar('Recording synced successfully');
        await _loadSyncStats();
        await _loadPendingRecordings();
      } else {
        _showSnackBar('Failed to sync recording', isError: true);
      }
    } catch (e) {
      _showSnackBar('Error syncing recording: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            const Icon(Icons.sync, color: Colors.blue),
            const SizedBox(width: 8),
            const Text(
              'Call Recording Sync',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            if (_isLoading)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Stats Cards
        if (_syncStats.isNotEmpty) ...[
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Local Files',
                  _syncStats['total_local']?.toString() ?? '0',
                  Icons.phone_android,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'Synced',
                  _syncStats['total_synced']?.toString() ?? '0',
                  Icons.cloud_done,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStatCard(
                  'Pending',
                  _syncStats['pending_sync']?.toString() ?? '0',
                  Icons.cloud_upload,
                  Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
        
        // Control Buttons
        Row(
          children: [
            Expanded(
              child: CommonFilledButton(
                onPressed: _isLoading ? null : _syncAllRecordings,
                label: 'Sync All Recordings',
                icon: Icons.cloud_upload,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CommonFilledButton(
                onPressed: _isLoading 
                    ? null 
                    : _isMonitoring 
                        ? _stopAutoMonitoring 
                        : _startAutoMonitoring,
                label: _isMonitoring ? 'Stop Auto-Sync' : 'Start Auto-Sync',
                icon: _isMonitoring ? Icons.stop : Icons.play_arrow,
                backgroundColor: _isMonitoring ? Colors.red : null,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Recordings List
        if (_pendingRecordings.isNotEmpty) ...[
          const Text(
            'Pending Recordings',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _pendingRecordings.length,
              itemBuilder: (context, index) {
                final filePath = _pendingRecordings[index];
                final fileName = filePath.split('/').last;
                
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.audiotrack),
                    title: Text(
                      fileName,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.cloud_upload, size: 20),
                      onPressed: _isLoading 
                          ? null 
                          : () => _syncSingleRecording(filePath),
                    ),
                  ),
                );
              },
            ),
          ),
        ] else ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text('All recordings are synced!'),
              ],
            ),
          ),
        ],
        
        const SizedBox(height: 16),
        
        // Auto-monitoring status
        if (_isMonitoring)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: const Row(
              children: [
                Icon(Icons.radar, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Auto-sync is monitoring for new recordings...',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: color.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
