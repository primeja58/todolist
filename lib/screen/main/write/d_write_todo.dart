import 'package:after_layout/after_layout.dart';
import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/dart/extension/datetime_extension.dart';
import 'package:fast_app_base/common/util/app_keyboard_util.dart';
import 'package:fast_app_base/common/widget/w_round_button.dart';
import 'package:fast_app_base/screen/main/write/vo_write_to_result.dart';
import 'package:flutter/material.dart';
import 'package:nav/dialog/dialog.dart';
import '../../../common/widget/scaffold/bottom_dialog_scaffold.dart';

class WriteTodoBottomSheet extends DialogWidget<WriteTodoResult> {
  WriteTodoBottomSheet({super.key});

  @override
  State<StatefulWidget> createState() => _WriteTodoBottomSheetState();
}

class _WriteTodoBottomSheetState extends DialogState<WriteTodoBottomSheet>
    with AfterLayoutMixin {
  DateTime _selectedDate = DateTime.now();
  final textController = TextEditingController();
  final node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BottomDialogScaffold(
      body: Column(
        children: [
          Row(
            children: [
              '할일을 작성해주세요.'.text
                  .size(18)
                  .bold
                  .make(),
              spacer,
              _selectedDate.formattedDate.text.make(),
              IconButton(
                onPressed: _selectDate,
                icon: const Icon(Icons.calendar_month),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(child: TextField(
                focusNode: node,
                controller: textController,
              )),
              RoundButton(text: '추가', onTap: () {
                widget.hide(WriteTodoResult(_selectedDate, textController.text));
              })
            ],
          )
        ],
      ),
    );
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate:DateTime.now().add(const Duration(days: 365 * 10))
    );
    if(date != null){
      _selectedDate = date;
    }
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    AppKeyboardUtil.show(context, node);
  }
}