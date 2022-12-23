import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horno/database/index.dart';
import 'package:horno/services/index.dart';
import 'package:horno/widgets/index.dart';
import 'package:provider/provider.dart';

class ItemOrderWidget extends StatefulWidget with RenderPage {
  final DetailDbModel detail;
  final Function()? onTap;

  const ItemOrderWidget({
    Key? key,
    this.onTap,
    required this.detail,
  }) : super(key: key);

  @override
  State<ItemOrderWidget> createState() => _ItemOrderWidgetState();
}

class _ItemOrderWidgetState extends State<ItemOrderWidget> {
  double _total = 1;

  @override
  void initState() {
    _total = widget.detail.weight! * widget.detail.servicePrice!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final detail = widget.detail;
    final provider = Provider.of<OrderService>(context, listen: false);

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _image(detail),
          SizedBox(
              width: MediaQuery.of(context).size.width - 120,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _wrappedTextWidget(detail.serviceName!),
                          IconButton(
                            onPressed: () {
                              provider.deleteDetail(detail.id!);
                            },
                            icon: Icon(Icons.delete,
                                size: 24, color: ColorsApp.colorSecondary),
                          )
                        ]),
                    const SpaceHeight(10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            _ControlOrderWidget(onChange: (weight) {
                              setState(() {
                                _total = weight * detail.servicePrice!;
                              });
                              provider.updateDetail(
                                detail.id!,
                                weight: weight,
                                total: weight * detail.servicePrice!,
                              );
                            }),
                            const SpaceWidth(5),
                            _wrappedTextWidget('kg')
                          ]),
                          _wrappedTextWidget('S/. ${_total.toStringAsFixed(2)}',
                              color: ColorsApp.colorSecondary)
                        ])
                  ]))
        ]);
  }

  SizedBox _image(DetailDbModel detail) {
    return SizedBox(
        width: 52,
        height: 49,
        child: ImageNetworkRoundedWidget(
          radius: 10,
          url: detail.serviceImage!,
        ));
  }

  TextWidget _wrappedTextWidget(String text,
      {double? fontSize = 20, Color? color}) {
    Color innerColor = color ?? ColorsApp.colorTitle;

    return TextWidget(text, fontSize: fontSize, color: innerColor);
  }
}

class _ControlOrderWidget extends StatefulWidget {
  final void Function(int) onChange;

  const _ControlOrderWidget({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  State<_ControlOrderWidget> createState() => _ControlOrderWidgetState();
}

class _ControlOrderWidgetState extends State<_ControlOrderWidget> {
  final TextEditingController controller = TextEditingController(text: "1");

  void subtract() {
    int value = int.tryParse(controller.text) ?? 1;

    if (value <= 1) {
      controller.text = "1";
      return;
    }

    value = value - 1;

    controller.text = value.toString();

    widget.onChange(value);
  }

  void add() {
    int value = int.tryParse(controller.text) ?? 1;

    if (value > 100) {
      controller.text = "100";
      return;
    }

    value = value + 1;

    controller.text = value.toString();

    widget.onChange(value);
  }

  void _handleChange() {
    int value = int.tryParse(controller.text) ?? 1;

    widget.onChange(value);
  }

  @override
  void initState() {
    controller.addListener(_handleChange);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 42,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorsApp.colorPrimary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButtonBgWidget(
            icon: Icons.remove,
            color: ColorsApp.colorTitle,
            backgroundColor: ColorsApp.colorPrimary,
            onPressed: () => subtract(),
          ),
          SizedBox(
              width: 40,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: controller,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    enabledBorder: _borderInput(),
                    border: _borderInput(),
                    focusedBorder: _borderInput()),
                keyboardType: TextInputType.number,
                style: GoogleFonts.openSans(
                    color: ColorsApp.colorTitle,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          IconButtonBgWidget(
            icon: Icons.add,
            color: ColorsApp.colorTitle,
            backgroundColor: ColorsApp.colorPrimary,
            onPressed: () => add(),
          )
        ],
      ),
    );
  }

  OutlineInputBorder _borderInput() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: ColorsApp.colorPrimary));
  }
}
