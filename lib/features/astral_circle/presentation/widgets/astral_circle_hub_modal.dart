import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/astral_circle_session.dart';
import '../notifiers/astral_circle_notifier.dart';
import '../../../tarot/presentation/widgets/glass_container.dart';

/// Modal hub allowing seekers to host or enter a synchronized real-time Astral Circle.
class AstralCircleHubModal extends ConsumerStatefulWidget {
  const AstralCircleHubModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AstralCircleHubModal(),
    );
  }

  @override
  ConsumerState<AstralCircleHubModal> createState() => _AstralCircleHubModalState();
}

class _AstralCircleHubModalState extends ConsumerState<AstralCircleHubModal> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _hostNameController = TextEditingController();
  final TextEditingController _guestNameController = TextEditingController();
  final TextEditingController _roomCodeController = TextEditingController();

  String _selectedSpread = 'threeCard';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _hostNameController.dispose();
    _guestNameController.dispose();
    _roomCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final circleAsync = ref.watch(astralCircleNotifierProvider);
    final circleNotifier = ref.read(astralCircleNotifierProvider.notifier);
    final session = circleAsync.value;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: AppColors.backgroundMidnight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          border: Border(
            top: BorderSide(color: AppColors.goldBright, width: 1.5),
          ),
        ),
        child: Column(
          children: [
            // Top Handle
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.goldMuted.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Header Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.goldBright.withValues(alpha: 0.15),
                          border: Border.all(color: AppColors.goldBright, width: 1.2),
                        ),
                        child: const Icon(Icons.all_inclusive, color: AppColors.goldBright, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ASTRAL CIRCLE',
                            style: GoogleFonts.cinzel(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.goldBright,
                              letterSpacing: 2.0,
                            ),
                          ),
                          Text(
                            'Synchronized Multi-Seeker Altar',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textSecondary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // If session is already active or waiting, display live room console
            if (session != null)
              Expanded(
                child: _buildActiveRoomView(context, session, circleNotifier),
              )
            else ...[
              // Tab Selector: Host vs Enter
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.cosmicSurface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.glassBorder),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: AppColors.goldBright.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.goldBright, width: 1.2),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColors.goldBright,
                    unselectedLabelColor: AppColors.textSecondary,
                    labelStyle: GoogleFonts.cinzel(fontSize: 12, fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(text: 'HOST CIRCLE'),
                      Tab(text: 'ENTER CIRCLE'),
                    ],
                  ),
                ),
              ),

              // Tab Views
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildHostTab(context, circleNotifier),
                    _buildJoinTab(context, circleNotifier),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Host Tab
  Widget _buildHostTab(BuildContext context, AstralCircleNotifier notifier) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SEEKER HOST NAME',
            style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.goldBright),
          ),
          const SizedBox(height: 8),
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            borderRadius: 12,
            child: TextField(
              controller: _hostNameController,
              style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                hintText: 'Enter your name or mystical title...',
                hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text(
            'SACRED SPREAD ARCHETYPE',
            style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.goldBright),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildSpreadChoice('threeCard', 'Three Fates', 'Past, Present, Future'),
              const SizedBox(width: 10),
              _buildSpreadChoice('solAndLuna', 'Sol & Luna', 'Twin Soul Conjunction'),
            ],
          ),
          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () async {
                HapticFeedback.mediumImpact();
                await notifier.createRoom(
                  hostName: _hostNameController.text,
                  spreadType: _selectedSpread,
                );
              },
              icon: const Icon(Icons.auto_awesome, color: AppColors.backgroundDeep),
              label: Text(
                'CONSECRATE ASTRAL ROOM',
                style: GoogleFonts.cinzel(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.backgroundDeep),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.goldBright,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Join Tab
  Widget _buildJoinTab(BuildContext context, AstralCircleNotifier notifier) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'YOUR SEEKER NAME',
            style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.goldBright),
          ),
          const SizedBox(height: 8),
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            borderRadius: 12,
            child: TextField(
              controller: _guestNameController,
              style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                hintText: 'Enter your seeker name...',
                hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text(
            'SACRED CIRCLE CODE (6 CHARS)',
            style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.goldBright),
          ),
          const SizedBox(height: 8),
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            borderRadius: 12,
            child: TextField(
              controller: _roomCodeController,
              textCapitalization: TextCapitalization.characters,
              style: GoogleFonts.cinzel(
                color: AppColors.goldBright,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0,
              ),
              decoration: const InputDecoration(
                hintText: 'e.g. SOL-742',
                hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14, letterSpacing: 1.0),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () async {
                final code = _roomCodeController.text.trim();
                if (code.isEmpty) return;

                HapticFeedback.mediumImpact();
                await notifier.joinRoom(
                  roomCode: code,
                  guestName: _guestNameController.text,
                );
              },
              icon: const Icon(Icons.login, color: AppColors.backgroundDeep),
              label: Text(
                'ENTER SACRED CIRCLE',
                style: GoogleFonts.cinzel(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.backgroundDeep),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.goldBright,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Spread Selection Pill
  Widget _buildSpreadChoice(String key, String title, String subtitle) {
    final isSelected = _selectedSpread == key;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() => _selectedSpread = key);
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.goldBright.withValues(alpha: 0.15) : AppColors.cosmicSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.goldBright : AppColors.glassBorder,
              width: isSelected ? 1.4 : 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.cinzel(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.goldBright : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9.5,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Live Room Console
  Widget _buildActiveRoomView(
    BuildContext context,
    AstralCircleSession session,
    AstralCircleNotifier notifier,
  ) {
    final isWaiting = session.status == AstralCircleStatus.waiting;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.cosmicSurface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.goldBright.withValues(alpha: 0.6)),
            ),
            child: Column(
              children: [
                Text(
                  'SACRED ROOM CODE',
                  style: GoogleFonts.cinzel(
                    fontSize: 11,
                    letterSpacing: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  session.roomCode,
                  style: GoogleFonts.cinzel(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldBright,
                    letterSpacing: 4.0,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: session.roomCode));
                        HapticFeedback.selectionClick();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Room code ${session.roomCode} copied to clipboard!'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy, size: 14, color: AppColors.goldBright),
                      label: Text('COPY CODE', style: GoogleFonts.cinzel(fontSize: 10, color: AppColors.goldBright)),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton.icon(
                      onPressed: () {
                        SharePlus.instance.share(
                          ShareParams(
                            text: 'Join my Oraculum Sacred Tarot Circle! Code: ${session.roomCode}',
                            subject: 'Oraculum Astral Circle Invite',
                          ),
                        );
                      },
                      icon: const Icon(Icons.share, size: 14, color: AppColors.goldBright),
                      label: Text('SHARE', style: GoogleFonts.cinzel(fontSize: 10, color: AppColors.goldBright)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Participants Status
          Row(
            children: [
              _buildParticipantCard(
                'HOST',
                session.hostName,
                true,
                session.activeTurn == AstralParticipantRole.host,
              ),
              const SizedBox(width: 12),
              _buildParticipantCard(
                'GUEST',
                session.guestName ?? 'Awaiting Seeker...',
                session.guestId != null,
                session.activeTurn == AstralParticipantRole.guest,
              ),
            ],
          ),
          const Spacer(),

          // Status & Action
          if (isWaiting) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.goldBright),
                ),
                const SizedBox(width: 10),
                Text(
                  'Awaiting partner to enter circle...',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: AppColors.goldMuted,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    HapticFeedback.lightImpact();
                    await notifier.leaveRoom();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFF8B8B)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'DISBAND CIRCLE',
                    style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFFFF8B8B)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.goldBright,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'GO TO ALTAR',
                    style: GoogleFonts.cinzel(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.backgroundDeep),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantCard(String role, String name, bool isConnected, bool isTurn) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isConnected ? AppColors.cosmicSurface : AppColors.cosmicSurface.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isTurn ? AppColors.goldBright : AppColors.glassBorder,
            width: isTurn ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  role,
                  style: GoogleFonts.cinzel(fontSize: 9.5, fontWeight: FontWeight.bold, color: AppColors.goldMuted),
                ),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isConnected ? const Color(0xFF8BFFB8) : Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: isConnected ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
            if (isTurn && isConnected) ...[
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.goldBright.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'DRAWING NOW',
                  style: GoogleFonts.cinzel(fontSize: 8, fontWeight: FontWeight.bold, color: AppColors.goldBright),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
