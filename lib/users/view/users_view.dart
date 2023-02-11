import 'package:flutter/material.dart';
import 'package:reqres/users/services/services.dart';
import 'package:reqres/users/view/detail_page_view.dart';

import '../model/users_model.dart';

class ListUsersView extends StatefulWidget {
  const ListUsersView({super.key});

  @override
  State<ListUsersView> createState() => _ListUsersViewState();
}

class _ListUsersViewState extends State<ListUsersView> {
  List<UsersModel>? _items;
  late final IUserServices _userModelManager;

  @override
  void initState() {
    _userModelManager = UserServices();
    fetchUserList();
    super.initState();
  }

  Future<void> fetchUserList() async {
    _items = await _userModelManager.getUserList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _items?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPageView(postId: _items?[index].userId),
                ));
              },
              leading: SizedBox(width: 100, child: Center(child: Text(_items?[index].userId.toString() ?? ''))),
              title: Text(_items?[index].title ?? ''),
              subtitle: Text(_items?[index].body ?? ''),
            ),
          );
        },
      ),
    );
  }
}
