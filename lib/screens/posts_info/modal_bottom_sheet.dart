import 'package:flutter/material.dart';
import 'package:test_app_eds/utils/styles/utils.dart';

class BottomSheetComments extends StatelessWidget {
  const BottomSheetComments({
    Key? key,
    required this.controllerName,
    required this.controllerEmail,
    required this.controllerBody,
    required this.onSendTap,
  }) : super(key: key);


  final TextEditingController controllerName;
  final TextEditingController controllerEmail;
  final TextEditingController controllerBody;
  final GestureTapCallback onSendTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Comment',style: MyTextStyles.header2,)),

            CustomTextField(controller: controllerName, maxLines: 2, hint: 'Name',inputType: TextInputType.name, ),
            CustomTextField(controller: controllerEmail, maxLines: 1, hint: 'E-mail',inputType: TextInputType.emailAddress,),
            CustomTextField(controller: controllerBody, maxLines: 4, hint: 'Comments',inputType: TextInputType.text,),
            GestureDetector(
              onTap:  onSendTap,
              child: Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: MyColors.blue,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Text('Send',style: MyTextStyles.header2.copyWith(color: MyColors.white),)),
            ),


          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.maxLines,
    required this.hint,
    required this.inputType,
  }) : super(key: key);

  final TextEditingController controller;
  final int maxLines;
  final String hint;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      height: 56,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: inputType,
        decoration: InputDecoration(
            hintText: '$hint',
            labelStyle: MyTextStyles.body,
            hintStyle: MyTextStyles.header3.copyWith(color: MyColors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))

        ),
      ),
    );
  }
}