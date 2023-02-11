// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:reqres/users/model/detail_model.dart';
import 'package:reqres/users/services/services.dart';

class DetailPageView extends StatefulWidget {
  const DetailPageView({
    Key? key,
    this.postId,
  }) : super(key: key);
  final int? postId;

  @override
  State<DetailPageView> createState() => _DetailPageViewState();
}

class _DetailPageViewState extends State<DetailPageView> {
  List<DetailModel>? _detail;
  late final IUserServices _detailManager;

  @override
  void initState() {
    _detailManager = UserServices();
    fetchDetailComments();
    super.initState();
  }

  Future<void> fetchDetailComments() async {
    _detail = await _detailManager.fetchDetail(widget.postId ?? 0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _detail?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_detail?[index].email ?? ''),
            ),
          );
        },
      ),
    );
  }
}
