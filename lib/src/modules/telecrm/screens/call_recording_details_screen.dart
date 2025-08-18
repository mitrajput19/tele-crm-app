import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../app/app.dart';

class CallRecordingDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> recording;

  const CallRecordingDetailsScreen({
    super.key,
    required this.recording,
  });

  @override
  State<CallRecordingDetailsScreen> createState() => _CallRecordingDetailsScreenState();
}

class _CallRecordingDetailsScreenState extends State<CallRecordingDetailsScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() => _position = position);
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() => _isPlaying = state == PlayerState.playing);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  String _formatFileSize(int? bytes) {
    if (bytes == null) return 'Unknown';
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }

  Future<void> _togglePlayback() async {
    final recordingUrl = widget.recording['recording_file_url'] as String?;
    if (recordingUrl == null) return;

    setState(() => _isLoading = true);

    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play(UrlSource(recordingUrl));
      }
    } catch (e) {
      showSnackbarBloc('Error playing audio: $e', SnackbarType.danger);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final recording = widget.recording;
    final hasRecording = recording['recording_file_url'] != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Call Recording Details'),
        actions: [
          if (hasRecording)
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                // TODO: Implement download functionality
                showSnackbarBloc('Download feature coming soon', SnackbarType.info);
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Audio Player Section
            if (hasRecording) ...[
              _buildAudioPlayerCard(),
              const SizedBox(height: 24),
            ],

            // Call Information
            _buildInfoCard(
              'Call Information',
              [
                _buildInfoRow('Phone Number', recording['phone_number'] ?? 'Unknown'),
                _buildInfoRow('Call Type', recording['call_type'] ?? 'Unknown'),
                _buildInfoRow('Call Direction', recording['call_direction'] ?? 'Unknown'),
                _buildInfoRow('Call Status', recording['call_status'] ?? 'Unknown'),
                _buildInfoRow('Duration', '${recording['duration_seconds'] ?? 0} seconds'),
              ],
            ),

            const SizedBox(height: 16),

            // Timing Information
            _buildInfoCard(
              'Timing Information',
              [
                _buildInfoRow('Start Time', _formatDateTime(recording['start_time'])),
                _buildInfoRow('End Time', _formatDateTime(recording['end_time'])),
                _buildInfoRow('Created At', _formatDateTime(recording['created_at'])),
                _buildInfoRow('Updated At', _formatDateTime(recording['updated_at'])),
              ],
            ),

            const SizedBox(height: 16),

            // Recording Information
            if (hasRecording) ...[
              _buildInfoCard(
                'Recording Information',
                [
                  _buildInfoRow('Audio Format', recording['audio_format'] ?? 'Unknown'),
                  _buildInfoRow('File Size', _formatFileSize(recording['file_size_bytes'])),
                  _buildInfoRow('Recording Path', recording['recording_file_path'] ?? 'Unknown'),
                  _buildInfoRow('Consent Recorded', recording['consent_recorded'] == true ? 'Yes' : 'No'),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // Call Quality & Outcome
            _buildInfoCard(
              'Call Quality & Outcome',
              [
                _buildInfoRow('Call Outcome', recording['call_outcome'] ?? 'Not specified'),
                _buildInfoRow('Quality Rating', recording['call_quality_rating']?.toString() ?? 'Not rated'),
                if (recording['call_notes'] != null)
                  _buildInfoRow('Notes', recording['call_notes']),
              ],
            ),

            const SizedBox(height: 16),

            // Follow-up Information
            _buildInfoCard(
              'Follow-up Information',
              [
                _buildInfoRow('Follow-up Required', recording['follow_up_required'] == true ? 'Yes' : 'No'),
                if (recording['follow_up_date'] != null)
                  _buildInfoRow('Follow-up Date', _formatDateTime(recording['follow_up_date'])),
              ],
            ),

            const SizedBox(height: 16),

            // Transcription Information
            if (recording['transcription_text'] != null || recording['transcription_status'] != null) ...[
              _buildInfoCard(
                'Transcription',
                [
                  _buildInfoRow('Status', recording['transcription_status'] ?? 'Unknown'),
                  if (recording['transcription_text'] != null)
                    _buildTranscriptionText(recording['transcription_text']),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // Tags
            if (recording['tags'] != null && (recording['tags'] as List).isNotEmpty) ...[
              _buildInfoCard(
                'Tags',
                [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (recording['tags'] as List)
                        .map((tag) => Chip(
                              label: Text(tag.toString()),
                              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            ))
                        .toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // Metadata
            if (recording['metadata'] != null && (recording['metadata'] as Map).isNotEmpty) ...[
              _buildInfoCard(
                'Additional Information',
                [
                  _buildMetadataSection(recording['metadata'] as Map<String, dynamic>),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // System Information
            _buildInfoCard(
              'System Information',
              [
                _buildInfoRow('Record ID', recording['id'] ?? 'Unknown'),
                _buildInfoRow('Contact ID', recording['contact_id'] ?? 'Not linked'),
                _buildInfoRow('Demo ID', recording['demo_id'] ?? 'Not linked'),
                _buildInfoRow('Caller ID', recording['caller_id'] ?? 'Unknown'),
                _buildInfoRow('Archived', recording['is_archived'] == true ? 'Yes' : 'No'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioPlayerCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.audiotrack, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Audio Recording',
                  style: Theme.of(context).textTheme.tsSemiBold16,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                        onPressed: _togglePlayback,
                        iconSize: 32,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                                trackHeight: 4,
                              ),
                              child: Slider(
                                value: _duration.inMilliseconds > 0
                                    ? _position.inMilliseconds / _duration.inMilliseconds
                                    : 0.0,
                                onChanged: (value) async {
                                  final position = Duration(
                                    milliseconds: (value * _duration.inMilliseconds).round(),
                                  );
                                  await _audioPlayer.seek(position);
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(_position),
                                  style: Theme.of(context).textTheme.tsRegular12,
                                ),
                                Text(
                                  _formatDuration(_duration),
                                  style: Theme.of(context).textTheme.tsRegular12,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.tsSemiBold16,
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.tsGrayRegular12,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'Not available',
              style: Theme.of(context).textTheme.tsRegular14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranscriptionText(String transcription) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Text(
        transcription,
        style: Theme.of(context).textTheme.tsRegular14,
      ),
    );
  }

  Widget _buildMetadataSection(Map<String, dynamic> metadata) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: metadata.entries.map((entry) {
        return _buildInfoRow(
          entry.key.replaceAll('_', ' ').toUpperCase(),
          entry.value?.toString(),
        );
      }).toList(),
    );
  }

  String _formatDateTime(dynamic dateTime) {
    if (dateTime == null) return 'Not available';
    try {
      final dt = DateTime.parse(dateTime.toString());
      return DateFormat('MMM dd, yyyy hh:mm a').format(dt);
    } catch (e) {
      return dateTime.toString();
    }
  }
}