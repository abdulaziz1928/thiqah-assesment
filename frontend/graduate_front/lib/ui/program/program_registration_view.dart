import 'package:flutter/material.dart';
import 'package:graduate_front/ui/common/custom_dropdown_button.dart';
import 'package:graduate_front/ui/program/program_registration_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/user.dart';
import '../../core/utils/styles.dart';
import '../common/custom_button.dart';

class ProgramRegistrationView extends StatefulWidget {
  const ProgramRegistrationView({Key? key}) : super(key: key);

  @override
  State<ProgramRegistrationView> createState() =>
      _ProgramRegistrationViewState();
}

class _ProgramRegistrationViewState extends State<ProgramRegistrationView> {
  final List<String> levels = [
    'masters',
    'bachelors',
    'high school',
    'Doctorate'
  ];
  final List<String> programs = [
    'Software Engineering',
    'Computer Science',
    'Information Systems',
    'Computer Engineering',
    'Information Technology'
  ];
  final List<String> faculties = [
    'information',
    'Software',
    'Business',
    'Research',
    'Design'
  ];
  String? levListVal, pListVal, fListVal;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return ViewModelBuilder<ProgramRegistrationViewModel>.reactive(
        viewModelBuilder: () => ProgramRegistrationViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Graduate Programs',
                  style: TStyles.veryLargeText.copyWith(fontSize: 30)),
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              automaticallyImplyLeading: false,
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: viewmodel.formKey,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// Level of Study
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Text(
                                  'Level of Study',
                                  style: TStyles.smallText
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                              levelButton(viewmodel),
                              SizedBox(
                                height: 5,
                              ),

                              /// Program
                              Text(
                                'Program',
                                style: TStyles.smallText
                                    .copyWith(color: Colors.black),
                              ),
                              programButton(viewmodel),
                              SizedBox(
                                height: 5,
                              ),

                              /// Faculty / Division
                              Text(
                                'Faculty / Division',
                                style: TStyles.smallText
                                    .copyWith(color: Colors.black),
                              ),
                              facultyButton(viewmodel),
                            ],
                          ),
                          SizedBox(height: 10),

                          /// Submit
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomButton(
                                  onPressed: () {
                                    viewmodel.email = user.email;
                                    viewmodel.submitProgram(context);
                                  },
                                  text: 'Join')
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  InputDecoration decoration(String hintText) => InputDecoration(
        hintText: hintText,
        hintTextDirection: TextDirection.ltr,
        hintStyle: TStyles.smallText,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      );
  DropdownButtonFormField levelButton(viewmodel) => DropdownButtonFormField(
        items: levels.map(buildItems).toList(),
        onChanged: (value) => setState(() => levListVal = value as String?),
        decoration: decoration('e.g., Masters Level'),
        onSaved: (value) {
          viewmodel.levListVal = value!;
        },
        validator: (val) {
          if (val == null) {
            return "select value";
          }
          return null;
        },
        value: levListVal,
      );
  DropdownButtonFormField programButton(viewmodel) => DropdownButtonFormField(
        items: programs.map(buildItems).toList(),
        decoration: decoration('e.g., Computer Science'),
        onChanged: (value) => setState(() => pListVal = value as String?),
        value: pListVal,
        onSaved: (value) {
          viewmodel.pListVal = value!;
        },
        validator: (val) {
          if (val == null) {
            return "select value";
          }
          return null;
        },
      );
  DropdownButtonFormField facultyButton(viewmodel) => DropdownButtonFormField(
        items: faculties.map(buildItems).toList(),
        decoration: decoration('e.g., Information'),
        onChanged: (value) => setState(() => fListVal = value as String?),
        value: fListVal,
        onSaved: (value) {
          viewmodel.fListVal = value!;
        },
        validator: (val) {
          if (val == null) {
            return "select value";
          }
          return null;
        },
      );
  DropdownMenuItem<String> buildItems(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
