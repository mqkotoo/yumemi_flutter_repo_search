// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:yumemi_flutter_repo_search/main.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataRepository = ref.read(dataRepositoryProvider);
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await dataRepository.getData('flutter');
          },
          child: const Text('test'),
        ),
      ),
    );
  }
}
