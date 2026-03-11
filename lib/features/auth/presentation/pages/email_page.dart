import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hoxton_task/core/design/components/app_button.dart';
import 'package:hoxton_task/core/design/palette/app_colors.dart';
import 'package:hoxton_task/core/design/palette/app_spacing.dart';
import 'package:hoxton_task/core/router/app_route_names.dart';
import 'package:hoxton_task/features/auth/presentation/controllers/email_entry_controller.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  late final EmailEntryController _entryController;

  @override
  void initState() {
    super.initState();
    _entryController = EmailEntryController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
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
                      _buildEmailField(),
                      const SizedBox(height: 20),
                      _buildLegalText(context),
                    ],
                  ),
                ),
              ),
              _buildContinueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Your Email',
          style: TextStyle(
            fontFamily: 'Sentient',
            fontWeight: FontWeight.w400,
            fontSize: 32,
            height: 1.25,
            color: AppColors.coolGrey,
          ),
        ),
        const SizedBox(height: AppSpacing.spacing8),
        Text(
          'Create a new account or continue where you left off.',
          style: TextStyle(
            fontSize: 14,
            height: 20 / 14,
            color: AppColors.coolGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: TextStyle(
            fontSize: 16,
            height: 24 / 16,
            color: AppColors.coolGrey,
          ),
        ),
        const SizedBox(height: AppSpacing.spacing4),
        TextField(
          controller: _emailController,
          focusNode: _emailFocusNode,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          onChanged: _entryController.validateEmail,
          decoration: InputDecoration(
            hintText: '',
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

  Widget _buildLegalText(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          color: AppColors.coolGrey,
        ),
        children: [
          const TextSpan(text: 'By clicking on continue you agree with our '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              color: AppColors.tertiary,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.tertiary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {},
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Terms & Conditions',
            style: TextStyle(
              color: AppColors.tertiary,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.tertiary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {},
          ),
          const TextSpan(text: '.'),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.spacing16),
      child: ValueListenableBuilder<bool>(
        valueListenable: _entryController.isChecking,
        builder: (context, isChecking, _) {
          return ValueListenableBuilder<bool>(
            valueListenable: _entryController.isEmailValid,
            builder: (context, isValid, __) {
              final isEnabled = isValid && !isChecking;
              return AppButton(
                label: isChecking ? 'Checking...' : 'Continue',
                isEnabled: isEnabled,
                onPressed: isEnabled ? _onContinue : null,
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _onContinue() async {
    final email = _emailController.text.trim();
    final result = await _entryController.checkEmail(email);
    if (!mounted) return;

    switch (result) {
      case EmailCheckSuccess(:final userExists):
        if (userExists) {
          context.push(
            '${AppRouteNames.password}?mode=verify',
            extra: email,
          );
        } else {
          context.push(
            '${AppRouteNames.password}?mode=set',
            extra: email,
          );
        }
      case EmailCheckFailure(:final message):
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(content: Text(message)),
        );
    }
  }
}
