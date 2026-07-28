import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../features/login/presentation/login_screen.dart';
import '../../../features/doctor/presentation/doctor_dashboard.dart';
import '../../../features/secretary/presentation/secretary_dashboard.dart';
import '../../../features/operator/presentation/operator_dashboard.dart';
import '../../../features/patient/presentation/patient_dashboard.dart';

// Declare a state provider for GoRouter so we can reactively trigger redirects
// when authentication states change in future development phases.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      // Login route (Entry point for all roles)
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/doctor',
        name: 'doctor',
        builder: (context, state) => const DoctorDashboard(),
      ),
      GoRoute(
        path: '/secretary',
        name: 'secretary',
        builder: (context, state) => const SecretaryDashboard(),
      ),
      GoRoute(
        path: '/operator',
        name: 'operator',
        builder: (context, state) => const OperatorDashboard(),
      ),
      GoRoute(
        path: '/patient',
        name: 'patient',
        builder: (context, state) => const PatientDashboard(),
      ),
    ],
    
    // Redirect handler (Placeholder for RBAC - Role-Based Access Control)
    redirect: (context, state) {
      // Future routing rule logic: e.g. checking auth provider state
      return null;
    },
  );
});
