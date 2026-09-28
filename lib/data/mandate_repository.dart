import '../models/mandate.dart';

/// Abstract contract for mandate data operations.
/// In production, this can be swapped with an API/HTTP implementation
/// without modifying any UI or presentation layer code.
abstract class MandateRepository {
  Future<List<Mandate>> getMandates();
  Future<Mandate?> getMandateById(String id);
}
