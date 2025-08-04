
import '../../../app/app.dart';
import '../../../domain/entities/dashboard_stats.dart';

class DashboardStatsWidget extends StatelessWidget {
  final DashboardStats stats;

  const DashboardStatsWidget({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // KPI Cards
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildKpiCard(
              'Total Leads',
              stats.totalLeads.toString(),
              Icons.people,
              AppColors.lightPrimary,
            ),
            _buildKpiCard(
              'Pending Calls',
              stats.pendingCalls.toString(),
              Icons.phone_callback,
              AppColors.warning,
            ),
            _buildKpiCard(
              'Today\'s Calls',
              stats.todayCalls.toString(),
              Icons.phone,
              AppColors.success,
            ),
            _buildKpiCard(
              'Connected Calls',
              stats.connectedCalls.toString(),
              Icons.phone_in_talk,
              AppColors.info,
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Performance Metrics
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Conversion Rate',
                '${stats.conversionRate.toStringAsFixed(1)}%',
                Icons.trending_up,
                AppColors.success,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                'Avg Call Duration',
                '${(stats.averageCallDuration / 60).toStringAsFixed(1)}m',
                Icons.timer,
                AppColors.info,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Call Status Breakdown Chart
        if (stats.callStatusBreakdown.isNotEmpty)
          CommonCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Call Status Breakdown',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: stats.callStatusBreakdown.map((statusCount) {
                          return PieChartSectionData(
                            value: statusCount.count.toDouble(),
                            title: '${statusCount.count}',
                            color: _getColorFromHex(statusCount.color),
                            radius: 60,
                            titleStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                        centerSpaceRadius: 40,
                        sectionsSpace: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: stats.callStatusBreakdown.map((statusCount) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _getColorFromHex(statusCount.color),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            statusCount.status,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon, Color color) {
    return CommonCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(navigatorKey.currentContext!).textTheme.titleLarge!.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(navigatorKey.currentContext!).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return CommonCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: color,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: Theme.of(navigatorKey.currentContext!).textTheme.titleMedium!.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    title,
                    style: Theme.of(navigatorKey.currentContext!).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
