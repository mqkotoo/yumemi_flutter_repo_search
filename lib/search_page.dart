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
              await DataRepository().getData('flutter');
            },
            child: const Text('test'),
        ),
      ),
    );
  }
}
