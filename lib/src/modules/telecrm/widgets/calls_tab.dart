
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/app.dart';
import '../bloc/telecrm_bloc.dart';
import '../widgets/call_item_widget.dart';

class CallsTab extends StatefulWidget {
  const CallsTab({super.key});

  @override
  State<CallsTab> createState() => _CallsTabState();
}

class _CallsTabState extends State<CallsTab> {
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter tabs
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildFilterChip('All', 'all'),
              const SizedBox(width: 8),
              _buildFilterChip('Completed', 'completed'),
              const SizedBox(width: 8),
              _buildFilterChip('Missed', 'missed'),
              const SizedBox(width: 8),
              _buildFilterChip('Failed', 'failed'),
            ],
          ),
        ),
        // Calls list
        Expanded(
          child: BlocBuilder<TeleCrmBloc, TeleCrmState>(
            builder: (context, state) {
              if (state is TeleCrmLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is TeleCrmError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error: ${state.message}',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      CommonFilledButton(
                        onPressed: () {
                          context.read<TeleCrmBloc>().add(LoadTeleCrmData());
                        },
                        text: 'Retry',
                      ),
                    ],
                  ),
                );
              }

              if (state is TeleCrmLoaded) {
                final calls = state.calls;

                if (calls.isEmpty) {
                  return const NoDataFound(
                    message: 'No calls found',
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<TeleCrmBloc>().add(LoadTeleCrmData());
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: calls.length,
                    itemBuilder: (context, index) {
                      final call = calls[index];
                      return CallItemWidget(
                        call: call,
                        onTap: () => _showCallDetails(context, call),
                        onCallback: () => _makeCallback(context, call),
                      );
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
        context.read<TeleCrmBloc>().add(
          LoadCalls(status: value == 'all' ? null : value),
        );
      },
    );
  }

  void _showCallDetails(BuildContext context, dynamic call) {
    // TODO: Navigate to call details
  }

  void _makeCallback(BuildContext context, dynamic call) {
    // TODO: Implement callback functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Making callback...'),
      ),
    );
  }
}
