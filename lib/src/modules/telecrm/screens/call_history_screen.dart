import '../../../app/app.dart';

class CallHistoryScreen extends StatelessWidget {
  const CallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CallHistoryBloc>()..add(const LoadCallHistory()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Call History'),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                context.read<CallHistoryBloc>().add(const LoadCallHistory());
              },
            ),
          ],
        ),
        body: BlocBuilder<CallHistoryBloc, CallHistoryState>(
          builder: (context, state) {
            if (state is CallHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (state is CallHistoryError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, size: 64, color: Colors.red),
                    SizedBox(height: 16),
                    Text('Error: ${state.message}'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CallHistoryBloc>().add(const LoadCallHistory());
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            
            if (state is CallHistoryLoaded) {
              if (state.callLogs.isEmpty) {
                return const Center(
                  child: Text('No call logs found'),
                );
              }
              
              return ListView.builder(
                itemCount: state.callLogs.length,
                itemBuilder: (context, index) {
                  final callLog = state.callLogs[index];
                  return CallLogTile(callLog: callLog);
                },
              );
            }
            
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class CallLogTile extends StatelessWidget {
  final CallLogEntry callLog;
  
  const CallLogTile({super.key, required this.callLog});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getCallTypeColor(),
        child: Icon(
          _getCallTypeIcon(),
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(
        callLog.displayName,
        style: Theme.of(context).textTheme.tsMedium16,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (callLog.number != null && callLog.name?.isNotEmpty == true)
            Text(
              callLog.number!,
              style: Theme.of(context).textTheme.tsGrayRegular12,
            ),
          Text(
            DateFormat('MMM dd, yyyy • hh:mm a').format(callLog.callDate),
            style: Theme.of(context).textTheme.tsGrayRegular12,
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            callLog.formattedDuration,
            style: Theme.of(context).textTheme.tsMedium12,
          ),
          Text(
            _getCallTypeText(),
            style: Theme.of(context).textTheme.tsGrayRegular10,
          ),
        ],
      ),
      onTap: () {
        if (callLog.number != null) {
          getIt<CallService>().makeDirectCall(callLog.number!);
        }
      },
    );
  }

  Color _getCallTypeColor() {
    switch (callLog.callType?.toString()) {
      case 'incoming':
        return Colors.green;
      case 'outgoing':
        return Colors.blue;
      case 'missed':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'unknown':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  IconData _getCallTypeIcon() {
    switch (callLog.callType?.toString()) {
      case 'incoming':
        return Icons.call_received;
      case 'outgoing':
        return Icons.call_made;
      case 'missed':
        return Icons.call_received;
      case 'rejected':
        return Icons.call_missed;
      case 'unknown':
        return Icons.call;
      default:
        return Icons.call;
    }
  }

  String _getCallTypeText() {
    switch (callLog.callType?.toString()) {
      case 'incoming':
        return 'Incoming';
      case 'outgoing':
        return 'Outgoing';
      case 'missed':
        return 'Missed';
      default:
        return 'Unknown';
    }
  }
}