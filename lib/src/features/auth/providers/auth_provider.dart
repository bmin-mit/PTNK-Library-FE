import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/user.dart';

@riverpod
User? loggedUser(Ref ref) {
  return null;
}

final loggerUserProvider = Provider<User?>((ref) {
  return loggedUser(ref);
});
