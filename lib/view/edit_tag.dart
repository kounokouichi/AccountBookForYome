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
        body: ListView.builder(
          itemCount: _vm.tagInfo.length,
          itemBuilder: (BuildContext context, int i) {
            return Text('data');
          },
        ),
      ),
    );
  }
}
