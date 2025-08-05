
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/app.dart';
import '../bloc/telecrm_bloc.dart';
import '../widgets/leads_tab.dart';
import '../widgets/calls_tab.dart';

class MyActivitiesScreen extends StatelessWidget {
  const MyActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TeleCrmBloc(
        supabaseService: SupabaseService(),
      )..add(LoadTeleCrmData()),
      child: const MyActivitiesView(),
    );
  }
}

class MyActivitiesView extends StatefulWidget {
  const MyActivitiesView({super.key});

  @override
  State<MyActivitiesView> createState() => _MyActivitiesViewState();
}

class _MyActivitiesViewState extends State<MyActivitiesView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Activities'),
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
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.people),
              text: 'LEADS',
            ),
            Tab(
              icon: Icon(Icons.call),
              text: 'CALLS',
            ),
          ],
        ),
      ),
      drawer: _buildDrawer(context),
      body: TabBarView(
        controller: _tabController,
        children: const [
          LeadsTab(),
          CallsTab(),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Text(
                    'HR',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Home Revise Education',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'advthomerevise@gmail.com',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Home Revise',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        // Handle change organization
                      },
                      child: const Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Quick actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickAction(
                icon: Icons.search,
                label: 'Search',
                onTap: () {
                  Navigator.pop(context);
                  // Handle search
                },
              ),
              _buildQuickAction(
                icon: Icons.leaderboard,
                label: 'Leaderboard',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/leaderboard');
                },
              ),
              _buildQuickAction(
                icon: Icons.person_add,
                label: 'Add lead/s',
                onTap: () {
                  Navigator.pop(context);
                  // Handle add leads
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Menu items
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(
                  icon: Icons.call,
                  title: 'My Calls',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildExpandableDrawerItem(
                  icon: Icons.campaign,
                  title: 'Campaigns',
                  children: [
                    'Active Campaigns',
                    'Campaign Analytics',
                    'Create Campaign',
                  ],
                ),
                _buildExpandableDrawerItem(
                  icon: Icons.people,
                  title: 'Leads/Filters',
                  children: [
                    'All Leads',
                    'Fresh Leads',
                    'Demo Scheduled',
                    'Follow-ups',
                  ],
                ),
                _buildExpandableDrawerItem(
                  icon: Icons.call_end,
                  title: 'Call Tracking',
                  children: [
                    'Call Recordings',
                    'Call Analytics',
                    'Call Reports',
                  ],
                ),
                _buildExpandableDrawerItem(
                  icon: Icons.message,
                  title: 'Msg Templates',
                  children: [
                    'WhatsApp Templates',
                    'SMS Templates',
                    'Email Templates',
                  ],
                ),
                _buildExpandableDrawerItem(
                  icon: Icons.label,
                  title: 'Labels',
                  children: [
                    'Priority Labels',
                    'Status Labels',
                    'Custom Labels',
                  ],
                ),
                _buildExpandableDrawerItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  children: [
                    'Account Settings',
                    'Notification Settings',
                    'Privacy Settings',
                  ],
                ),
              ],
            ),
          ),
          // WhatsApp notification
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.phone_android,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Enable Whatsapp Notification',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.green,
                  size: 16,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'v-400.1',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildExpandableDrawerItem({
    required IconData icon,
    required String title,
    required List<String> children,
  }) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(title),
      children: children.map((child) {
        return ListTile(
          contentPadding: const EdgeInsets.only(left: 72, right: 16),
          title: Text(
            child,
            style: const TextStyle(fontSize: 14),
          ),
          onTap: () {
            Navigator.pop(context);
            // Handle child item tap
          },
        );
      }).toList(),
    );
  }
}
