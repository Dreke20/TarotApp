import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/external_launch_service.dart';
import '../../tarot/presentation/widgets/glass_container.dart';
import 'auth_notifier.dart';

enum AuthTab { signIn, signUp }

/// Consecrated Obsidian-and-Gold Authentication Modal.
/// Provides seamless Sign In, Sign Up, and Password Recovery.
class AuthModal extends ConsumerStatefulWidget {
  final AuthTab initialTab;

  const AuthModal({
    super.key,
    this.initialTab = AuthTab.signIn,
  });

  static Future<void> show(BuildContext context, {AuthTab initialTab = AuthTab.signIn}) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (_) => AuthModal(initialTab: initialTab),
    );
  }

  @override
  ConsumerState<AuthModal> createState() => _AuthModalState();
}

class _AuthModalState extends ConsumerState<AuthModal> {
  static const List<String> _zodiacSigns = [
    'Aries', 'Taurus', 'Gemini', 'Cancer',
    'Leo', 'Virgo', 'Libra', 'Scorpio',
    'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'
  ];

  late AuthTab _currentTab;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  String _selectedSunSign = 'Scorpio';
  bool _obscurePassword = true;
  bool _isResettingPassword = false;

  @override
  void initState() {
    super.initState();
    _currentTab = widget.initialTab;
    ref.read(authNotifierProvider.notifier).clearError();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _switchTab(AuthTab tab) {
    if (_currentTab != tab) {
      setState(() {
        _currentTab = tab;
        _isResettingPassword = false;
      });
      ref.read(authNotifierProvider.notifier).clearError();
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final notifier = ref.read(authNotifierProvider.notifier);

    if (_isResettingPassword) {
      final success = await notifier.sendPasswordReset(email);
      if (success && mounted) {
        setState(() => _isResettingPassword = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✨ Sacred recovery link dispatched to $email. Check your inbox!'),
            backgroundColor: AppColors.cosmicSurface,
          ),
        );
      }
      return;
    }

    if (_currentTab == AuthTab.signIn) {
      final success = await notifier.signIn(email, password);
      if (success && mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✨ Welcome back to the Altar, ${ref.read(authNotifierProvider).profile?.displayName ?? 'Seeker'}!'),
            backgroundColor: AppColors.cosmicSurface,
          ),
        );
      }
    } else {
      final name = _nameController.text.trim().isEmpty ? 'Cosmic Seeker' : _nameController.text.trim();
      final success = await notifier.signUp(
        email,
        password,
        name,
        sunSign: _selectedSunSign,
      );
      if (success && mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✨ Welcome to Oraculum, $name. Your sanctuary is consecrated!'),
            backgroundColor: AppColors.cosmicSurface,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;
    final errorMessage = authState.errorMessage;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: GlassContainer(
        borderRadius: 24,
        blur: 28,
        fillColor: AppColors.backgroundMidnight.withValues(alpha: 0.95),
        borderColor: AppColors.goldBright.withValues(alpha: 0.7),
        borderWidth: 1.5,
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with celestial star and close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome, color: AppColors.goldBright, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          _isResettingPassword
                              ? 'RECOVER SANCTUARY KEY'
                              : (_currentTab == AuthTab.signIn ? 'SEEKER SIGN IN' : 'CONSECRATE ACCOUNT'),
                          style: GoogleFonts.cinzel(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldBright,
                            letterSpacing: 1.6,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const Divider(color: AppColors.glassBorder, height: 22),

                // Tab Switcher (Sign In vs Create Account)
                if (!_isResettingPassword) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.glassFillStrong,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.glassBorder),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _switchTab(AuthTab.signIn),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 9),
                              decoration: BoxDecoration(
                                color: _currentTab == AuthTab.signIn
                                    ? AppColors.goldBright.withValues(alpha: 0.22)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: _currentTab == AuthTab.signIn
                                      ? AppColors.goldBright
                                      : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'LOG IN',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.bold,
                                    color: _currentTab == AuthTab.signIn
                                        ? AppColors.goldBright
                                        : AppColors.textMuted,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _switchTab(AuthTab.signUp),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 9),
                              decoration: BoxDecoration(
                                color: _currentTab == AuthTab.signUp
                                    ? AppColors.goldBright.withValues(alpha: 0.22)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: _currentTab == AuthTab.signUp
                                      ? AppColors.goldBright
                                      : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'SIGN UP',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.bold,
                                    color: _currentTab == AuthTab.signUp
                                        ? AppColors.goldBright
                                        : AppColors.textMuted,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                ],

                // Error Banner
                if (errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF450A0A).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFF87171).withValues(alpha: 0.6)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline, color: Color(0xFFF87171), size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            errorMessage,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.5,
                              color: const Color(0xFFFECACA),
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Sign Up Exclusive Fields: Name & Sun Sign
                if (_currentTab == AuthTab.signUp && !_isResettingPassword) ...[
                  _buildTextField(
                    controller: _nameController,
                    label: 'Seeker Name / Spiritual Alias',
                    hintText: 'e.g. Celeste Mystic',
                    icon: Icons.person_outline,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter a name or alias';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  // Sun Sign Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '☀️ Sun Sign (Astrological Essence)',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.glassFillStrong,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.glassBorder),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedSunSign,
                            isExpanded: true,
                            dropdownColor: AppColors.backgroundMidnight,
                            icon: const Icon(Icons.arrow_drop_down, color: AppColors.goldBright),
                            items: _zodiacSigns.map((sign) {
                              return DropdownMenuItem<String>(
                                value: sign,
                                child: Text(
                                  sign,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedSunSign = val);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                ],

                // Email Field
                _buildTextField(
                  controller: _emailController,
                  label: 'Celestial Email Address',
                  hintText: 'seeker@domain.com',
                  icon: Icons.alternate_email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!val.contains('@') || !val.contains('.')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),

                // Password Field (Omitted during password reset)
                if (!_isResettingPassword) ...[
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Secret Sanctuary Key (Password)',
                    hintText: '••••••••',
                    icon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: AppColors.textSecondary,
                        size: 18,
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    validator: (val) {
                      if (val == null || val.length < 6) {
                        return 'Key must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),

                  // Forgot Password Link in Sign In
                  if (_currentTab == AuthTab.signIn) ...[
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _isResettingPassword = true);
                          ref.read(authNotifierProvider.notifier).clearError();
                        },
                        child: Text(
                          'Forgot Secret Key?',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: AppColors.goldMuted,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],

                if (_isResettingPassword) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        foregroundColor: AppColors.goldMuted,
                      ),
                      icon: const Icon(Icons.arrow_back, size: 14),
                      label: Text(
                        'Back to Sign In',
                        style: GoogleFonts.cinzel(fontSize: 10.5, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        setState(() => _isResettingPassword = false);
                        ref.read(authNotifierProvider.notifier).clearError();
                      },
                    ),
                  ),
                ],
                const SizedBox(height: 18),

                // Primary Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.goldBright,
                    foregroundColor: AppColors.backgroundDeep,
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 3,
                  ),
                  onPressed: isLoading ? null : _submit,
                  child: isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.backgroundDeep),
                          ),
                        )
                      : Text(
                          _isResettingPassword
                              ? 'DISPATCH RECOVERY LINK'
                              : (_currentTab == AuthTab.signIn ? 'ENTER SANCTUARY' : 'CONSECRATE ACCOUNT'),
                          style: GoogleFonts.cinzel(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.4,
                          ),
                        ),
                ),
                const SizedBox(height: 12),

                // Continue as Guest Option
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Continue as Guest Seeker',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                // Terms & Privacy Note
                if (_currentTab == AuthTab.signUp) ...[
                  const SizedBox(height: 6),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          'By consecrating an account, you agree to the ',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 9.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => ExternalLaunchService.openTermsOfService(context),
                          child: Text(
                            'Terms',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 9.5,
                              color: AppColors.goldMuted,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          ' & ',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 9.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => ExternalLaunchService.openPrivacyPolicy(context),
                          child: Text(
                            'Privacy Policy',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 9.5,
                              color: AppColors.goldMuted,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: AppColors.textPrimary,
          ),
          cursorColor: AppColors.goldBright,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: AppColors.textMuted.withValues(alpha: 0.6),
            ),
            prefixIcon: Icon(icon, color: AppColors.goldMuted, size: 18),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.glassFillStrong,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.glassBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.glassBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.goldBright, width: 1.2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFF87171), width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFF87171), width: 1.2),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
