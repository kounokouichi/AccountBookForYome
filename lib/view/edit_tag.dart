import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumechanaccountbook/view_model/edit_tag_view_model.dart';

class EditTag extends ConsumerStatefulWidget {
  const EditTag({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditTagState();
}

class _EditTagState extends ConsumerState<EditTag> {
  EditTagViewModel get _vm => ref.watch(editTagProvider('id'));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _vm.getAllTag();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        appBar: AppBar(title: const Text('タグ編集')),
        body: ListView.builder(
          itemCount: _vm.tagInfo.length,
          itemBuilder: (BuildContext context, int i) {
            return Dismissible(
              key: Key(_vm.tagInfo[i].name),
              child: ListTile(title: Text(_vm.tagInfo[i].name)),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 10),
                color: Colors.red,
                child: const Icon(Icons.delete),
              ),
              onDismissed: (direction) {
                // TODO:削除（フラグ寝かせ）機能追加
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            // 登録機能追加
            // 既にあるタグの時はフラグを起こす
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
