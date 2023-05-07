import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumechanaccountbook/view/tag/edit_tag_create_dialog.dart';
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
                _vm.deleteTag(_vm.tagInfo[i].id);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            _showDialog();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _showDialog() async {
    showDialog(
        context: context,
        builder: (_) {
          return const EditTagCreateDialog();
        });
  }
}
