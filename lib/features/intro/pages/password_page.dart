import 'package:flutter/material.dart';
import 'package:hoxton_task/core/design/components/app_image.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/core/extensions/string_validation_extension.dart';
import 'package:hoxton_task/core/utils/password_requirements.dart';
import 'package:hoxton_task/core/utils/password_validation.dart';

enum PasswordPageMode { set, confirm, verify }

class PasswordPage extends StatefulWidget {
  const PasswordPage._({required this.mode, this.onSubmit});

  factory PasswordPage.set({VoidCallback? onSubmit}) {
    return PasswordPage._(mode: PasswordPageMode.set, onSubmit: onSubmit);
  }

  factory PasswordPage.confirm({VoidCallback? onSubmit}) {
    return PasswordPage._(mode: PasswordPageMode.confirm, onSubmit: onSubmit);
  }

  factory PasswordPage.verify({VoidCallback? onSubmit}) {
    return PasswordPage._(mode: PasswordPageMode.verify, onSubmit: onSubmit);
  }

  final PasswordPageMode mode;
  final VoidCallback? onSubmit;

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  bool _obscurePassword = true;
  PasswordValidationStatus _passwordStatus =
      const PasswordValidationStatus.empty();

  String get _title {
    switch (widget.mode) {
      case PasswordPageMode.set:
        return 'Set Password';
      case PasswordPageMode.confirm:
        return 'Confirm Password';
      case PasswordPageMode.verify:
        return 'Enter Password';
    }
  }

  String get _subtitle {
    switch (widget.mode) {
      case PasswordPageMode.set:
        return 'Create a strong password to secure your account.';
      case PasswordPageMode.confirm:
        return 'Re-enter your password to confirm.';
      case PasswordPageMode.verify:
        return 'Enter your password to sign in.';
    }
  }

  String get _buttonText {
    switch (widget.mode) {
      case PasswordPageMode.set:
        return 'Set Password';
      case PasswordPageMode.confirm:
        return 'Confirm';
      case PasswordPageMode.verify:
        return 'Sign In';
    }
  }

  bool get _showRequirements => widget.mode == PasswordPageMode.set;

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyGreenTint2,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.spacing16,
                  AppSpacing.spacing48,
                  AppSpacing.spacing16,
                  AppSpacing.spacing16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: AppSpacing.spacing24),
                    _buildPasswordField(),
                    if (_showRequirements) ...[
                      const SizedBox(height: AppSpacing.spacing16),
                      _buildPasswordRequirements(),
                      const SizedBox(height: AppSpacing.spacing16),
                      _buildSecurityMessage(),
                    ],
                  ],
                ),
              ),
            ),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _title,
          style: const TextStyle(
            fontFamily: 'Sentient',
            fontWeight: FontWeight.w400,
            fontSize: 32,
            height: 1.25,
            color: AppColors.coolGrey,
          ),
        ),
        const SizedBox(height: AppSpacing.spacing8),
        Text(
          _subtitle,
          style: const TextStyle(
            fontSize: 14,
            height: 20 / 14,
            color: AppColors.coolGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: TextStyle(
            fontSize: 16,
            height: 24 / 16,
            color: AppColors.coolGrey,
          ),
        ),
        const SizedBox(height: AppSpacing.spacing4),
        TextField(
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          obscureText: _obscurePassword,
          obscuringCharacter: '•',
          onChanged: (value) {
            setState(() {
              _passwordStatus = value.passwordValidationStatus;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing16,
              vertical: AppSpacing.spacing8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.spacing8),
              borderSide: const BorderSide(color: AppColors.coolGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.spacing8),
              borderSide: const BorderSide(color: AppColors.coolGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.spacing8),
              borderSide: const BorderSide(color: AppColors.coolGrey),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.coolGrey,
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
            height: 24 / 16,
            color: AppColors.coolGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordRequirements() {
    final List<PasswordRequirement> requirements =
        PasswordRequirementsPresenter.build(_passwordStatus);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password Requirements:',
          style: TextStyle(
            fontSize: 14,
            height: 20 / 14,
            fontWeight: FontWeight.w500,
            color: AppColors.coolGrey,
          ),
        ),
        const SizedBox(height: AppSpacing.spacing8),
        ...requirements.map(
          (requirement) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.spacing8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppImage.svg(
                  requirement.isMet
                      ? 'assets/images/svg/radio_ticked_alt.svg'
                      : 'assets/images/svg/radio_empty_alt.svg',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: AppSpacing.spacing8),
                Expanded(
                  child: Text(
                    requirement.label,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 20 / 14,
                      color: AppColors.coolGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.spacing8),
          decoration: const BoxDecoration(
            color: AppColors.secondaryAccent,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.lock_outline, size: 20, color: AppColors.coolGrey),
        ),
        const SizedBox(width: AppSpacing.spacing8),
        Expanded(
          child: Text(
            'We use bank-grade encryption and multi-layer protection to keep your financial data safe from day one.',
            style: TextStyle(
              fontSize: 14,
              height: 20 / 14,
              color: AppColors.coolGrey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: () => widget.onSubmit?.call(),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primaryBg,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing16,
              vertical: 10,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.spacing8),
            ),
          ),
          child: Text(
            _buttonText,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              height: 24 / 16,
            ),
          ),
        ),
      ),
    );
  }
}
