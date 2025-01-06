import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/visitor.dart';

final visitorFormProvider =
    StateNotifierProvider<VisitorFormNotifier, AsyncValue<void>>((ref) {
  return VisitorFormNotifier();
});

class VisitorFormNotifier extends StateNotifier<AsyncValue<void>> {
  VisitorFormNotifier() : super(const AsyncValue.data(null));

  Future<void> submitVisitor(Visitor visitor) async {
    state = const AsyncValue.loading();
    try {
      // TODO: Implement actual submission logic
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
