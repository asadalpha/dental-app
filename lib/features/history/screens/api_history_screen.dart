import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:dental_app/core/theme/app_colors.dart';
import '../models/history_model.dart';

class ApiHistoryScreen extends StatefulWidget {
  const ApiHistoryScreen({super.key});

  @override
  State<ApiHistoryScreen> createState() => _ApiHistoryScreenState();
}

class _ApiHistoryScreenState extends State<ApiHistoryScreen> {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  List<HistoryModel> _historyData = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      developer.log('Fetching history (Dio)...', name: 'ApiHistoryScreen');

      final response = await _dio.get(
        'https://dummyjson.com/posts',
        queryParameters: {'limit': 20},
      );

      developer.log(
        'Status Code: ${response.statusCode}',
        name: 'ApiHistoryScreen',
      );

      if (response.statusCode != 200) {
        throw Exception('Server error ${response.statusCode}');
      }

      final List data = response.data['posts'];

      _historyData = data
          .map(
            (e) => HistoryModel(
              userId: e['userId'],
              id: e['id'],
              title: e['title'],
              body: e['body'],
            ),
          )
          .toList();

      setState(() {
        _isLoading = false;
      });

      developer.log(
        'Fetched ${_historyData.length} items',
        name: 'ApiHistoryScreen',
      );
    } on DioException catch (e, st) {
      developer.log(
        'Dio error',
        name: 'ApiHistoryScreen',
        error: e.message,
        stackTrace: st,
      );
      _useMockFallback(e.message ?? 'Network error');
    } catch (e, st) {
      developer.log(
        'Unknown error',
        name: 'ApiHistoryScreen',
        error: e,
        stackTrace: st,
      );
      _useMockFallback(e.toString());
    }
  }

  void _useMockFallback(String error) {
    final mockData = List.generate(
      10,
      (i) => HistoryModel(
        userId: 1,
        id: i + 1,
        title: i.isEven
            ? 'Initial Dental Scan'
            : 'Follow-up Analysis',
        body: 'Fallback used due to: $error',
      ),
    );

    setState(() {
      _historyData = mockData;
      _isLoading = false;
      _errorMessage = error;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Offline mode: showing demo data'),
          backgroundColor: AppColors.secondary,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Retry',
            textColor: Colors.white,
            onPressed: _fetchHistory,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: _buildBody(),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Scan History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.secondary.withOpacity(0.05),
                Colors.white,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_historyData.isEmpty) {
      return const SliverFillRemaining(
        child: Center(child: Text('No history available')),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) =>
            _buildHistoryItem(_historyData[index], index),
        childCount: _historyData.length,
      ),
    );
  }

  Widget _buildHistoryItem(HistoryModel item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: index.isEven
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.secondary.withOpacity(0.1),
          child: Icon(
            index.isEven
                ? Icons.biotech_rounded
                : Icons.medical_services_rounded,
            color:
                index.isEven ? AppColors.primary : AppColors.secondary,
          ),
        ),
        title: Text(
          'Scan #${item.id}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms, delay: (index * 40).ms)
        .slideY(begin: 0.1);
  }
}
