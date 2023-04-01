import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yumemi_flutter_repo_search/repository/data_repository.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async{
              final result = await DataRepository().getData('flutter');
              if (kDebugMode) {
                print(result);
              }
            },
            child: const Text('test'),
        ),
      ),
    );
  }
}
