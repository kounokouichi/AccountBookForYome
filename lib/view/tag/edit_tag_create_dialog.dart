import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumechanaccountbook/view_model/edit_tag_view_model.dart';

/// タグ作成画面
class EditTagCreateDialog extends ConsumerStatefulWidget {
  const EditTagCreateDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditTagCreateDialogState();
}

class _EditTagCreateDialogState extends ConsumerState<EditTagCreateDialog> {
  EditTagViewModel get _vm => ref.watch(editTagProvider('id'));

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(12.0),
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'タグ名'),
          controller: _vm.tagController,
          maxLength: 100,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            child: const Text('登録'),
            onPressed: () {
              _vm.insertTag();
              if (_vm.message.isEmpty) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
      ],
    );
  }
}
