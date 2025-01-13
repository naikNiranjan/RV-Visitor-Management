import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/services/host_service.dart';
import '../../../auth/data/services/auth_service.dart';
import '../../domain/models/host.dart';
import '../../domain/models/visitor.dart';

part 'host_providers.g.dart';

@Riverpod(keepAlive: true)
HostService hostService(HostServiceRef ref) {
  return HostService();
}

@riverpod
Stream<int> pendingApprovalsCount(PendingApprovalsCountRef ref) {
  final hostService = ref.watch(hostServiceProvider);
  final user = ref.watch(authProvider).value;
  if (user == null) return Stream.value(0);

  return hostService.getPendingApprovalsCount(user.email!);
}

@riverpod
Stream<int> approvedVisitorsCount(ApprovedVisitorsCountRef ref) {
  final hostService = ref.watch(hostServiceProvider);
  final user = ref.watch(authProvider).value;
  if (user == null) return Stream.value(0);

  return hostService.getApprovedVisitorsCount(user.email!);
}

@riverpod
Stream<int> visitHistoryCount(VisitHistoryCountRef ref) {
  final hostService = ref.watch(hostServiceProvider);
  final user = ref.watch(authProvider).value;
  if (user == null) return Stream.value(0);

  return hostService.getVisitHistoryCount(user.email!);
}

@riverpod
Stream<List<Visitor>> pendingApprovals(PendingApprovalsRef ref) {
  final hostService = ref.watch(hostServiceProvider);
  final user = ref.watch(authProvider).value;
  if (user == null) return Stream.value([]);

  return hostService.getPendingApprovals(user.email!).map(
        (snapshots) => snapshots.map((data) {
          return Visitor.fromJson(data);
        }).toList(),
      );
}

@riverpod
Stream<List<Visitor>> approvedVisitors(ApprovedVisitorsRef ref) {
  final hostService = ref.watch(hostServiceProvider);
  final user = ref.watch(authProvider).value;
  if (user == null) return Stream.value([]);

  return hostService.getApprovedVisitors(user.email!).map(
        (snapshots) => snapshots.map((data) {
          return Visitor.fromJson(data);
        }).toList(),
      );
}

@riverpod
Stream<List<Visitor>> visitHistory(VisitHistoryRef ref) {
  final hostService = ref.watch(hostServiceProvider);
  final user = ref.watch(authProvider).value;
  if (user == null) return Stream.value([]);

  return hostService.getVisitHistory(user.email!).map(
        (snapshots) => snapshots.map((data) {
          return Visitor.fromJson(data);
        }).toList(),
      );
}

@riverpod
Stream<Host?> currentHost(CurrentHostRef ref) {
  final hostService = ref.watch(hostServiceProvider);
  final user = ref.watch(authProvider).value;
  if (user == null) return Stream.value(null);

  return hostService.getHostStream(user.email!);
}

@riverpod
Stream<List<Map<String, dynamic>>> hostNotifications(HostNotificationsRef ref) {
  final hostService = ref.watch(hostServiceProvider);
  final user = ref.watch(authProvider).value;
  if (user == null) return Stream.value([]);

  return hostService.getHostNotifications(user.email!);
}
