import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hoxton_task/core/design/components/app_button.dart';
import 'package:hoxton_task/core/design/components/app_image.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/core/extensions/string_validation_extension.dart';
import 'package:hoxton_task/core/router/app_route_names.dart';
import 'package:hoxton_task/core/utils/password_requirements.dart';
import 'package:hoxton_task/core/utils/password_validation.dart';
import 'package:hoxton_task/features/auth/presentation/controllers/auth_flow_controller.dart';

enum PasswordPageMode { set, verify }

class PasswordPage extends StatefulWidget {
  const PasswordPage._({
    required this.mode,
    this.email,
  });

  factory PasswordPage.set({String? email}) {
    return PasswordPage._(mode: PasswordPageMode.set, email: email);
  }

  factory PasswordPage.verify({String? email}) {
    return PasswordPage._(mode: PasswordPageMode.verify, email: email);
  }

  final PasswordPageMode mode;
  final String? email;

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final ValueNotifier<bool> _obscurePassword = ValueNotifier(true);
  late final AuthFlowController _authController;

  bool get _isButtonEnabled {
    final value = _passwordController.text;
    switch (widget.mode) {
      case PasswordPageMode.set:
        return value.passwordValidationStatus.isValid;
      case PasswordPageMode.verify:
        return value.isNotEmpty;
    }
  }

  String get _title {
    switch (widget.mode) {
      case PasswordPageMode.set:
        return 'Set Password';
      case PasswordPageMode.verify:
        return 'Enter Password';
    }
  }

  String get _subtitle {
    switch (widget.mode) {
      case PasswordPageMode.set:
        return 'Create a strong password to secure your account.';
      case PasswordPageMode.verify:
        return 'Enter your password to sign in.';
    }
  }

  String get _buttonText {
    switch (widget.mode) {
      case PasswordPageMode.set:
        return 'Set Password';
      case PasswordPageMode.verify:
        return 'Sign In';
    }
  }

  bool get _showRequirements => widget.mode == PasswordPageMode.set;

  @override
  void initState() {
    super.initState();
    _authController = AuthFlowController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _obscurePassword.dispose();
    _authController.dispose();
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
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _passwordController,
                      builder: (context, value, _) {
                        final status = value.text.passwordValidationStatus;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildPasswordField(),
                            if (_showRequirements) ...[
                              const SizedBox(height: AppSpacing.spacing16),
                              _buildPasswordRequirements(status),
                              const SizedBox(height: AppSpacing.spacing16),
                              _buildSecurityMessage(),
                            ],
                          ],
                        );
                      },
                    ),
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
        ValueListenableBuilder<bool>(
          valueListenable: _obscurePassword,
          builder: (context, obscure, _) {
            return TextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              obscureText: obscure,
              obscuringCharacter: '•',
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
                    obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.coolGrey,
                    size: 20,
                  ),
                  onPressed: () {
                    _obscurePassword.value = !obscure;
                  },
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                height: 24 / 16,
                color: AppColors.coolGrey,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPasswordRequirements(PasswordValidationStatus status) {
    final List<PasswordRequirement> requirements =
        PasswordRequirementsPresenter.build(status);
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

  bool get _canSubmit => widget.email != null;

  Future<void> _onSubmit() async {
    final email = widget.email;
    final password = _passwordController.text;
    if (email == null) return;

    final result = await _authController.submit(
      email: email,
      password: password,
      isSignIn: widget.mode == PasswordPageMode.verify,
    );
    if (!mounted) return;

    switch (result) {
      case AuthFlowSuccess(:final isSignIn, email: final successEmail):
        if (isSignIn) {
          context.go(AppRouteNames.home);
        } else if (successEmail != null) {
          context.go(AppRouteNames.preBoarding, extra: successEmail);
        }
      case AuthFlowFailure(:final message):
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(content: Text(message)),
        );
    }
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      child: ValueListenableBuilder<bool>(
        valueListenable: _authController.isSubmitting,
        builder: (context, submitting, _) {
          return ValueListenableBuilder<TextEditingValue>(
            valueListenable: _passwordController,
            builder: (context, value, _) {
              final enabled =
                  !submitting && _isButtonEnabled && _canSubmit;
              return AppButton(
                label: submitting ? 'Please wait...' : _buttonText,
                isEnabled: enabled,
                onPressed: enabled ? _onSubmit : null,
              );
            },
          );
        },
      ),
    );
  }
}
