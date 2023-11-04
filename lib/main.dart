// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ColorScheme appColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue);
    return MaterialApp(
      title: 'M08 - Form (C)',
      theme: ThemeData(
        colorScheme: appColorScheme,
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: EdgeInsets.all(10)),
        chipTheme: ChipThemeData(
            backgroundColor: appColorScheme.primary,
            labelStyle: TextStyle(color: appColorScheme.onPrimary),
            secondaryLabelStyle: TextStyle(color: appColorScheme.onSecondary),
            showCheckmark: false,
            selectedColor: appColorScheme.secondary,
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String title = 'Adrián López Villalba';
  final _formKey = GlobalKey<FormBuilderState>();
  var _curLength = 0;
  final _maxLength = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      //-------------------------------------------------
                      SizedBox(height: 20),
                      FormBuilderChoiceChip(
                          name: 'choice_chips',
                          alignment: WrapAlignment.spaceEvenly,
                          decoration: InputDecoration(
                            labelText: 'Choice Chips',
                          ),
                          options: [
                            FormBuilderChipOption(
                              value: 'Flutter',
                              avatar: Image.asset('assets/flutter_icon.png'),
                            ),
                            FormBuilderChipOption(
                                value: 'Android', avatar: Icon(Icons.android)),
                            FormBuilderChipOption(value: 'Chrome OS'),
                          ]),
                      //-------------------------------------------------
                      SizedBox(height: 20),
                      FormBuilderSwitch(
                          decoration: InputDecoration(
                            labelText: 'Switch',
                          ),
                          name: 'switch',
                          title: Text('This is a switch')),
                      //-------------------------------------------------
                      SizedBox(height: 20),
                      FormBuilderTextField(
                        name: 'textField',
                        decoration: InputDecoration(
                          labelText: 'Text Field',
                          prefixIcon: Icon(Icons.calendar_month),
                          counterText: '$_curLength/$_maxLength',
                        ),
                        autovalidateMode: AutovalidateMode.always,
                        validator: FormBuilderValidators.maxLength(7),
                        onChanged: (value) {
                          setState(() {
                            _curLength = value!.length;
                          });
                        },
                      ),
                      //-------------------------------------------------
                      SizedBox(height: 20),
                      FormBuilderDropdown(
                        name: 'dropdown',
                        decoration: InputDecoration(
                          labelText: 'Dropdown Field',
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: 'finland', child: Text('Finland')),
                          DropdownMenuItem(
                              value: 'spain', child: Text('Spain')),
                          DropdownMenuItem(
                              value: 'uk', child: Text('United Kingdom')),
                        ],
                        onChanged: (String? value) {
                          debugPrint(value);
                        },
                      ),
                      //-------------------------------------------------
                      SizedBox(height: 20),
                      FormBuilderRadioGroup(
                        name: "radioGroup",
                        decoration: InputDecoration(
                          labelText: 'Radio Group Model',
                        ),
                        orientation: OptionsOrientation.vertical,
                        // separator: const Padding(padding: EdgeInsets.all(20)),
                        options: const [
                          FormBuilderFieldOption(value: 'Option 1'),
                          FormBuilderFieldOption(value: 'Option 2'),
                          FormBuilderFieldOption(value: 'Option 3'),
                          FormBuilderFieldOption(value: 'Option 4'),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.upload),
          onPressed: () {
            _formKey.currentState?.saveAndValidate();
            String? formString = _formKey.currentState?.value.toString();
            alertDialog(context, formString!);
          }),
    );
  }
}

void alertDialog(BuildContext context, String contentText) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      icon: Icon(Icons.check_circle),
      title: const Text('Submission complete'),
      content: Text(contentText),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Tancar'),
          child: const Text('Tancar'),
        ),
      ],
    ),
  );
}
