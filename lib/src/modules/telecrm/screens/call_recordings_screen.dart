import '../../../app/app.dart';

class CallRecordingsScreen extends StatefulWidget {
  const CallRecordingsScreen({super.key});

  @override
  State<CallRecordingsScreen> createState() => _CallRecordingsScreenState();
}

class _CallRecordingsScreenState extends State<CallRecordingsScreen> {
  List<Map<String, dynamic>> recordings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecordings();
  }

  Future<void> _loadRecordings() async {
    try {
      final supabaseService = getIt<SupabaseService>();
      final loadedRecordings = await supabaseService.getCallRecordings();
      setState(() {
        recordings = loadedRecordings;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackbarBloc('Error loading recordings: $e', SnackbarType.danger);
    }
  }

  Future<void> _syncRecordings() async {
    try {
      setState(() {
        isLoading = true;
      });
      
      final callService = getIt<CallService>();
      final result = await callService.syncCallRecordings();
      
      setState(() {
        isLoading = false;
      });
      
      showSnackbarBloc(
        'Sync completed: ${result['uploaded']} uploaded, ${result['failed']} failed',
        SnackbarType.success,
      );
      
      // Reload recordings after sync
      _loadRecordings();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackbarBloc('Sync failed: $e', SnackbarType.danger);
    }
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _formatCallState(String? state) {
    if (state == null) return 'Unknown';
    switch (state) {
      case 'connected':
        return 'Completed';
      case 'ended':
        return 'Ended';
      case 'dialing':
        return 'Missed';
      default:
        return state.toUpperCase();
    }
  }

  Color _getStateColor(String? state) {
    switch (state) {
      case 'connected':
        return AppColors.success;
      case 'ended':
        return AppColors.info;
      case 'dialing':
        return AppColors.warning;
      default:
        return AppColors.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Recordings'),
        actions: [
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: _syncRecordings,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadRecordings,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : recordings.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call_end, size: 64, color: AppColors.gray),
                      SizedBox(height: 16),
                      Text(
                        'No call recordings found',
                        style: Theme.of(context).textTheme.tsGrayRegular16,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: recordings.length,
                  itemBuilder: (context, index) {
                    final recording = recordings[index];
                    final callDate = DateTime.tryParse(recording['start_time'] ?? '');
                    
                    return CommonCard(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recording['metadata']?['lead_name'] ?? 'Unknown Contact',
                                      style: Theme.of(context).textTheme.tsMedium16,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      recording['phone_number'] ?? 'No phone',
                                      style: Theme.of(context).textTheme.tsGrayRegular14,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStateColor(recording['call_state']).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _formatCallState(recording['call_state']),
                                  style: Theme.of(context).textTheme.tsRegular12.copyWith(
                                    color: _getStateColor(recording['call_state']),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: AppColors.gray),
                              SizedBox(width: 4),
                              Text(
                                'Duration: ${_formatDuration(recording['duration_seconds'] ?? 0)}',
                                style: Theme.of(context).textTheme.tsRegular12,
                              ),
                              SizedBox(width: 16),
                              Icon(Icons.calendar_today, size: 16, color: AppColors.gray),
                              SizedBox(width: 4),
                              Text(
                                callDate != null 
                                    ? DateFormat('MMM dd, yyyy HH:mm').format(callDate)
                                    : 'Unknown date',
                                style: Theme.of(context).textTheme.tsRegular12,
                              ),
                            ],
                          ),
                          if (recording['recording_path'] != null) ...[
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.folder, size: 16, color: AppColors.gray),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    recording['recording_path'],
                                    style: Theme.of(context).textTheme.tsRegular10,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}