import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/button/elevated_button.dart';
import 'route_path.dart';

class ErrorRoutePage extends StatelessWidget {
  final GoRouterState? state;

  const ErrorRoutePage({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Large Icon
              const Icon(
                Icons.broken_image_rounded,
                size: 120,
              ),
              const SizedBox(height: 32),

              // Title
              const Text(
                'Page Not Found',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Subtitle
              const Text(
                "Oops! The page you are looking for doesn't exist or has been moved.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Error Details (if any)
              if (state?.error != null) ...[
                Column(
                  children: [
                    const Text(
                      'Technical Details:',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state!.error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],

              // Actions
              PrimaryButton(
                onPressed: () => context.go(RoutePath.home),
                text: 'Go Home',
              ),

              if (context.canPop()) ...[
                const SizedBox(height: 16),
                TextButton.icon(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Go Back'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
