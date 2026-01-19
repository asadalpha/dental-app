import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dental_app/core/theme/app_colors.dart';
import '../models/history_model.dart';
import 'dart:developer' as developer;

class ApiHistoryScreen extends StatefulWidget {
  const ApiHistoryScreen({super.key});

  @override
  State<ApiHistoryScreen> createState() => _ApiHistoryScreenState();
}

class _ApiHistoryScreenState extends State<ApiHistoryScreen> {
  List<HistoryModel> _historyData = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    developer.log('Fetching history from API...', name: 'ApiHistoryScreen');
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=20'),
      );

      developer.log(
        'API Response Status: ${response.statusCode}',
        name: 'ApiHistoryScreen',
      );

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        setState(() {
          _historyData = decodedData
              .map((json) => HistoryModel.fromJson(json))
              .toList();
          _isLoading = false;
          _errorMessage = null;
        });
        developer.log(
          'Successfully fetched ${_historyData.length} items',
          name: 'ApiHistoryScreen',
        );
      } else {
        throw Exception(
          'Failed to load history (Status: ${response.statusCode})',
        );
      }
    } catch (e, stacktrace) {
      developer.log(
        'Error fetching history, using fallback',
        name: 'ApiHistoryScreen',
        error: e,
        stackTrace: stacktrace,
      );
      _useMockFallback(e.toString());
    }
  }

  void _useMockFallback(String originalError) {
    final mockItems = List.generate(
      10,
      (index) => HistoryModel(
        userId: 1,
        id: index + 101, // Different IDs from real API
        title: index % 2 == 0 ? "Initial Dental Scan" : "Follow-up Analysis",
        body: "Mock data used due to: $originalError",
      ),
    );

    setState(() {
      _historyData = mockItems;
      _isLoading = false;
      _errorMessage = null;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Offline Mode: Displaying demo data'),
            backgroundColor: AppColors.secondary,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                _fetchHistory();
              },
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Scan History",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.secondary.withOpacity(0.05),
                      Colors.white,
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: _buildSliverBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverBody() {
    if (_isLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: AppColors.error,
              ),
              const SizedBox(height: 16),
              const Text(
                "Failed to load history",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _errorMessage = null;
                  });
                  _fetchHistory();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(120, 48),
                ),
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }

    if (_historyData.isEmpty) {
      return const SliverFillRemaining(
        child: Center(child: Text("No history available")),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = _historyData[index];
        return _buildHistoryItem(item, index);
      }, childCount: _historyData.length),
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.secondary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                index % 2 == 0
                    ? Icons.biotech_rounded
                    : Icons.medical_services_rounded,
                color: index % 2 == 0 ? AppColors.primary : AppColors.secondary,
                size: 24,
              ),
            ),
            title: Text(
              "Scan #${item.id}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  "20 Jan",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                Text(
                  "10:${(index % 60).toString().padLeft(2, '0')} AM",
                  style: const TextStyle(
                    color: AppColors.textLight,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            onTap: () {
              developer.log(
                'Tapped on Scan #${item.id}',
                name: 'ApiHistoryScreen',
              );
            },
          ),
        )
        .animate()
        .fadeIn(delay: (index * 50).ms, duration: 400.ms)
        .slideY(begin: 0.1, end: 0);
  }
}
