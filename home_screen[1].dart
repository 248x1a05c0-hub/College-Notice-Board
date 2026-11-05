import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/notice.dart';
import '../providers/notice_provider.dart';
import '../widgets/empty_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/notice_card.dart';
import 'add_notice_screen.dart';
import 'notice_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _openAddNotice(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddNoticeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NoticeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Campus Connect', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('College Notice Board',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh notices',
            onPressed: () => context.read<NoticeProvider>().loadNotices(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddNotice(context),
        icon: const Icon(Icons.add),
        label: const Text('Add notice'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                onChanged: context.read<NoticeProvider>().setSearchQuery,
                decoration: const InputDecoration(
                  hintText: 'Search notices...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  const Text('Recent announcements',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text('${provider.filteredNotices.length} notices',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            Expanded(
              child: _buildNoticeBody(context, provider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoticeBody(BuildContext context, NoticeProvider provider) {
    if (provider.isLoading) {
      return const LoadingWidget();
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              Text(provider.errorMessage!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => context.read<NoticeProvider>().loadNotices(),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final notices = provider.filteredNotices;
    if (notices.isEmpty) {
      return EmptyWidget(
        title: provider.searchQuery.isEmpty
            ? 'No notices available'
            : 'No matching notices',
        message: provider.searchQuery.isEmpty
            ? 'Tap “Add notice” to publish the first announcement.'
            : 'Try another search word or clear your filters.',
        icon: Icons.inbox_outlined,
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<NoticeProvider>().loadNotices(),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        itemCount: notices.length,
        itemBuilder: (context, index) {
          final notice = notices[index];
          return NoticeCard(
            notice: notice,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NoticeDetailScreen(notice: notice),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
