// =============================================================================
// app_errors.dart — Gestion d'erreurs FinTemp
// =============================================================================
// Emplacement : core/errors/app_errors.dart
//
// Modèle d'erreur unifié. Même si le template utilise des fake repositories,
// cette structure permet au client d'y brancher son API facilement.
// =============================================================================

import 'package:equatable/equatable.dart';

// ── Failure (couche Domain) ───────────────────────────────────────────────────

/// Classe de base pour toutes les erreurs métier.
abstract class Failure extends Equatable {
  const Failure({required this.message, this.code});

  final String  message;
  final String? code;

  @override
  List<Object?> get props => [message, code];
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Erreur réseau. Vérifiez votre connexion.', super.code});
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Une erreur serveur est survenue.', super.code});
}

class AuthFailure extends Failure {
  const AuthFailure({super.message = 'Authentification invalide.', super.code});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Ressource introuvable.', super.code});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'Une erreur inconnue est survenue.', super.code});
}

// ── AppException (couche Data) ────────────────────────────────────────────────

/// Exception technique, levée dans la couche Data.
/// Convertie en Failure dans les repositories.
class AppException implements Exception {
  const AppException({required this.message, this.statusCode});

  final String message;
  final int?   statusCode;

  /// Convertit le code HTTP en Failure appropriée.
  Failure toFailure() {
    switch (statusCode) {
      case 401: return const AuthFailure(code: '401');
      case 403: return const AuthFailure(message: 'Accès refusé.', code: '403');
      case 404: return const NotFoundFailure(code: '404');
      case 500: return const ServerFailure(code: '500');
      default:  return UnknownFailure(message: message);
    }
  }

  @override
  String toString() => 'AppException($statusCode): $message';
}
