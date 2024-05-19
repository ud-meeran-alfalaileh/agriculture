import 'package:agriculture/src/config/sizes/sizes.dart';
import 'package:agriculture/src/config/theme/theme.dart';
import 'package:agriculture/src/feature/login/model/login_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FormWidget extends StatefulWidget {
  FormWidget({
    required this.formModel,
    this.ontap,
    super.key,
  });
  FormModel formModel;
  VoidCallback? ontap;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(0.01 * context.screenWidth)),
          ),
          child: TextFormField(
              onTap: widget.ontap,

              ///color change
              cursorColor: AppTheme.lightAppColors.bordercolor,
              style: TextStyle(color: AppTheme.lightAppColors.primary),
              readOnly: widget.formModel.enableText,
              inputFormatters: widget.formModel.inputFormat,
              keyboardType: widget.formModel.type,
              validator: widget.formModel.validator,
              obscureText: widget.formModel.invisible,
              controller: widget.formModel.controller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: widget.ontap,
                    icon: Icon(widget.formModel.icon),
                  ),
                  filled: true,
                  fillColor:
                      AppTheme.lightAppColors.containercolor.withOpacity(.05),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppTheme.lightAppColors.primary.withOpacity(.5),
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(0.03 * context.screenWidth))),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppTheme.lightAppColors.primary.withOpacity(.5),
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(0.03 * context.screenWidth))),
                  hintText: widget.formModel.hintText.tr,
                  hintStyle: TextStyle(
                      fontFamily: "Tajawal",
                      color: AppTheme.lightAppColors.primary.withOpacity(.5),
                      fontSize: 17)))),
    );
  }
}
