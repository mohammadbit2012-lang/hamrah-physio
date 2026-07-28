import 'package:flutter/material.dart';

/// AppColors defines the high-fidelity color palette used across Hamrah Physio.
/// It uses medical teal and clinical slate accents to establish a clean,
/// professional, and trust-building visual style.
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation.

  // Primary Medical Accents
  static const Color primaryLight = Color(0xFF0D9488); // Clinical Teal
  static const Color primaryDark = Color(0xFF14B8A6); // High-contrast Light Teal
  
  // Secondary Structural Colors
  static const Color secondaryLight = Color(0xFF475569); // Professional Slate
  static const Color secondaryDark = Color(0xFF94A3B8); // Muted Blue-grey Slate
  
  // Neutral Backgrounds
  static const Color backgroundLight = Color(0xFFF8FAFC); // Clean Clinical Off-white
  static const Color backgroundDark = Color(0xFF0F172A); // Midnight Slate (Dark Mode)
  
  // Neutral Surfaces
  static const Color surfaceLight = Color(0xFFFFFFFF); // Standard White
  static const Color surfaceDark = Color(0xFF1E293B); // Dark Slate Card Container
  
  // Functional Status Colors
  static const Color success = Color(0xFF10B981); // Success Emerald Green
  static const Color warning = Color(0xFFF59E0B); // Cautionary Amber
  static const Color error = Color(0xFFEF4444); // Alarm Ruby Red
  static const Color info = Color(0xFF3B82F6); // Informative Blue
  
  // Border & Grid Lines
  static const Color borderLight = Color(0xFFE2E8F0); // Subtle Slate Dividers
  static const Color borderDark = Color(0xFF334155); // Dark Theme Dividers

  // Text Styling Colors (High contrast)
  static const Color textPrimaryLight = Color(0xFF0F172A); // Near Black
  static const Color textSecondaryLight = Color(0xFF475569); // Dark Grey
  
  static const Color textPrimaryDark = Color(0xFFF8FAFC); // Near White
  static const Color textSecondaryDark = Color(0xFF94A3B8); // Soft Grey
}