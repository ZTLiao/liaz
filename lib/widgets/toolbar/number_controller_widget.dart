import 'package:flutter/material.dart';

//faith 2020年04月20日11:05:57
class NumberControllerWidget extends StatefulWidget {
  //高度
  final double height;

  //输入框的宽度 总体宽度为自适应
  final double width;

  //按钮的宽度
  final double iconWidth;

  //默认输入框显示的数量
  final String numText;

  //点击加号回调 数量
  final ValueChanged addValueChanged;

  //点击减号回调 数量
  final ValueChanged removeValueChanged;

  //点击减号任意一个回调 数量
  final ValueChanged updateValueChanged;

  const NumberControllerWidget({
    super.key,
    this.height = 30,
    this.width = 40,
    this.iconWidth = 40,
    this.numText = '0',
    required this.addValueChanged,
    required this.removeValueChanged,
    required this.updateValueChanged,
  });

  @override
  State<StatefulWidget> createState() => _NumberControllerWidgetState();
}

class _NumberControllerWidgetState extends State<NumberControllerWidget> {
  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.numText;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: widget.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(width: 1, color: Colors.black12)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //减号
              _coustomIconButton(
                icon: Icons.remove,
                isAdd: false,
              ),
              //输入框
              Container(
                width: widget.width,
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(width: 1, color: Colors.black12),
                        right: BorderSide(width: 1, color: Colors.black12))),
                child: TextField(
                  controller: textController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 0, top: 2, bottom: 2, right: 0),
                    border: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
              ),
              //加号
              _coustomIconButton(
                icon: Icons.add,
                isAdd: true,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _coustomIconButton({required IconData icon, required bool isAdd}) {
    return SizedBox(
      width: widget.iconWidth,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(icon),
        onPressed: () {
          var num = int.parse(textController.text);
          if (!isAdd && num == 0) return;
          if (isAdd) {
            num++;
            widget.addValueChanged(num);
          } else {
            num--;
            widget.removeValueChanged(num);
          }
          textController.text = '$num';
          widget.updateValueChanged(num);
        },
      ),
    );
  }
}
