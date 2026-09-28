import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import '../../data/mandate_repository.dart';
import '../../data/mock_mandate_repository.dart';
import '../../models/mandate.dart';
import '../../widgets/mandate_card.dart';
import '../../widgets/mandate_summary_header.dart';
import '../../widgets/mandates_empty_state.dart';
import '../../widgets/mandates_error_state.dart';
import '../../widgets/mandates_loading_state.dart';
import '../demo/demo_scenario_selector.dart';
import 'mandate_details_screen.dart';

/// Primary Mandates Screen.
/// Manages loading, empty, error, and populated states with smooth transitions,
/// clean information architecture, scalable lists, and a demo scenario switcher.
class MandatesScreen extends StatefulWidget {
  final MandateRepository repository;

  const MandatesScreen({
    super.key,
    required this.repository,
  });

  @override
  State<MandatesScreen> createState() => _MandatesScreenState();
}

class _MandatesScreenState extends State<MandatesScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  List<Mandate> _mandates = [];
  String _selectedFilter = 'all'; // 'all', 'active', 'other'

  @override
  void initState() {
    super.initState();
    _loadMandates();
  }

  Future<void> _loadMandates() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await widget.repository.getMandates();
      if (!mounted) return;
      setState(() {
        _mandates = data;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  void _onScenarioChanged(DemoScenario scenario) {
    if (widget.repository is MockMandateRepository) {
      (widget.repository as MockMandateRepository).setScenario(scenario);
      _loadMandates();
    }
  }

  void _navigateToDetails(Mandate mandate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MandateDetailsScreen(mandate: mandate),
      ),
    );
  }

  void _handleAutopaySetup() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Auto Pay setup workflow is ready to connect with bank gateway.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mockRepo = widget.repository is MockMandateRepository
        ? widget.repository as MockMandateRepository
        : null;

    final activeMandates = _mandates.where((m) => m.isActive).toList();
    final otherMandates = _mandates.where((m) => !m.isActive).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Returning to Auto Pay settings'),
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          tooltip: 'Back',
        ),
        title: const Text('Mandates'),
        elevation: 0,
        actions: [
          // Discreet Demo Scenario Switcher for evaluation
          if (mockRepo != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primarySurface,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.primaryLight),
                  ),
                ),
                icon: const Icon(Icons.tune_rounded, size: 16, color: AppColors.primary),
                label: const Text(
                  'Demo',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                onPressed: () => DemoScenarioSelector.show(
                  context,
                  currentScenario: mockRepo.currentScenario,
                  onScenarioSelected: _onScenarioChanged,
                ),
              ),
            ),
        ],
      ),
      body: _buildBody(activeMandates, otherMandates),
    );
  }

  Widget _buildBody(List<Mandate> activeMandates, List<Mandate> otherMandates) {
    // 1. Loading State
    if (_isLoading) {
      return const MandatesLoadingState();
    }

    // 2. Error State
    if (_errorMessage != null) {
      return MandatesErrorState(
        errorMessage: _errorMessage,
        onRetry: () {
          // If in error scenario, switch to mixedStatuses on retry so user experiences recovery
          if (widget.repository is MockMandateRepository) {
            final repo = widget.repository as MockMandateRepository;
            if (repo.currentScenario == DemoScenario.error) {
              repo.setScenario(DemoScenario.mixedStatuses);
            }
          }
          _loadMandates();
        },
      );
    }

    // 3. Empty State
    if (_mandates.isEmpty) {
      return MandatesEmptyState(
        onSetupAutopay: _handleAutopaySetup,
      );
    }

    // 4. Populated Mandates List with vertical scrolling & organization
    return RefreshIndicator(
      onRefresh: _loadMandates,
      color: AppColors.primary,
      backgroundColor: Colors.white,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: [
          // Summary Header (below App Bar)
          SliverToBoxAdapter(
            child: MandateSummaryHeader(
              totalCount: _mandates.length,
              activeCount: activeMandates.length,
              otherCount: otherMandates.length,
              selectedFilter: _selectedFilter,
              onFilterSelected: (filter) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 8),
          ),

          // Render List based on filter and grouping
          ..._buildMandateSlivers(activeMandates, otherMandates),

          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMandateSlivers(
    List<Mandate> activeMandates,
    List<Mandate> otherMandates,
  ) {
    // Case 1: Filter is 'active'
    if (_selectedFilter == 'active') {
      return [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final mandate = activeMandates[index];
              return MandateCard(
                key: ValueKey(mandate.id),
                mandate: mandate,
                onTap: () => _navigateToDetails(mandate),
              );
            },
            childCount: activeMandates.length,
          ),
        ),
      ];
    }

    // Case 2: Filter is 'other' (inactive, expired, cancelled)
    if (_selectedFilter == 'other') {
      return [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final mandate = otherMandates[index];
              return MandateCard(
                key: ValueKey(mandate.id),
                mandate: mandate,
                onTap: () => _navigateToDetails(mandate),
              );
            },
            childCount: otherMandates.length,
          ),
        ),
      ];
    }

    // Case 3: Filter is 'all' with both Active and Other mandates present
    // Organize into clean, accessible grouped sections
    if (activeMandates.isNotEmpty && otherMandates.isNotEmpty) {
      return [
        // Section: Active Mandates
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 4),
            child: Row(
              children: [
                const Text('Active Mandates', style: AppTypography.sectionTitle),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.statusActiveBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.statusActiveBorder),
                  ),
                  child: Text(
                    '${activeMandates.length}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.statusActiveText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final mandate = activeMandates[index];
              return MandateCard(
                key: ValueKey(mandate.id),
                mandate: mandate,
                onTap: () => _navigateToDetails(mandate),
              );
            },
            childCount: activeMandates.length,
          ),
        ),

        // Section: Past & Inactive Mandates
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 4),
            child: Row(
              children: [
                const Text('Past & Inactive Mandates', style: AppTypography.sectionTitle),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.statusInactiveBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.statusInactiveBorder),
                  ),
                  child: Text(
                    '${otherMandates.length}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.statusInactiveText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final mandate = otherMandates[index];
              return MandateCard(
                key: ValueKey(mandate.id),
                mandate: mandate,
                onTap: () => _navigateToDetails(mandate),
              );
            },
            childCount: otherMandates.length,
          ),
        ),
      ];
    }

    // Case 4: Only active or only other mandates exist
    return [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final mandate = _mandates[index];
            return MandateCard(
              key: ValueKey(mandate.id),
              mandate: mandate,
              onTap: () => _navigateToDetails(mandate),
            );
          },
          childCount: _mandates.length,
        ),
      ),
    ];
  }
}
