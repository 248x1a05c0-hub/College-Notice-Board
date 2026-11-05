import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/notice_provider.dart';
import '../widgets/empty_widget.dart';
import '../widgets/notice_card.dart';
import 'notice_detail_screen.dart';

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({super.key});

  static const departments = [
    'All',
    'CSE',
    'ECE',
    'EEE',
    'IT',
    'Civil',
    'Mechanical',
    'General',
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NoticeProvider>();
    final notices = provider.filteredNotices;

    return Scaffold(
      appBar: AppBar(title: const Text('Departments')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: departments.map((department) {
                return ChoiceChip(
                  label: Text(department),
                  selected: provider.selectedDepartment == department,
                  onSelected: (_) => context
                      .read<NoticeProvider>()
                      .selectDepartment(department),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '${notices.length} notices found',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : notices.isEmpty
                    ? const EmptyWidget(
                        title: 'No notices in this department',
                        message: 'Choose another department or add a notice.',
                        icon: Icons.filter_alt_off,
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                        itemCount: notices.length,
                        itemBuilder: (context, index) {
                          final notice = notices[index];
                          return NoticeCard(
                            notice: notice,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      NoticeDetailScreen(notice: notice),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
