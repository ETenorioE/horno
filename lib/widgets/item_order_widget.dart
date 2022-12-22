import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horno/widgets/index.dart';

class ItemOrderWidget extends StatefulWidget with RenderPage {
  final String text;
  final double price;
  final String image;
  final Function()? onTap;

  const ItemOrderWidget({
    Key? key,
    required this.text,
    required this.price,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  State<ItemOrderWidget> createState() => _ItemOrderWidgetState();
}

class _ItemOrderWidgetState extends State<ItemOrderWidget> {
  double _total = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 52,
          height: 49,
          child: ImageNetworkRoundedWidget(radius: 10, url: widget.image),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _wrappedTextWidget(widget.text),
                  Icon(
                    Icons.delete,
                    size: 24,
                    color: ColorsApp.colorSecondary,
                  ),
                ],
              ),
              const SpaceHeight(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _ControlOrderWidget(
                        onChange: (p0) {
                          setState(() {
                            _total = p0 * widget.price;
                          });
                        },
                      ),
                      const SpaceWidth(5),
                      _wrappedTextWidget('kg')
                    ],
                  ),
                  _wrappedTextWidget('S/. $_total',
                      color: ColorsApp.colorSecondary),
                ],
              )
            ],
          ),
        ),
      ],
    );
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
  int _counter = 1;

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
