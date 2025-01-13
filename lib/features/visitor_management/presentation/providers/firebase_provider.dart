import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/firebase_service.dart';
import '../../../host_management/data/services/host_service.dart';
import '../../../host_management/domain/models/host.dart';

final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

final hostServiceProvider = Provider<HostService>((ref) {
  return HostService();
});

final hostDataProvider = FutureProvider.family<Host?, String>((ref, email) async {
  return await ref.read(hostServiceProvider).fetchHostData(email);
}); 