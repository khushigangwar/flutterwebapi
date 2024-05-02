import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterwebapi/api_handler.dart';
import 'package:flutterwebapi/model.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final User user;
  const EditPage({super.key, required this.user});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler apiHandler = ApiHandler();
  late http.Response response;
  void updateData() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;
      debugPrint('User ID: ${widget.user.id}');
      debugPrint('User Name: ${data['user']}');
      debugPrint('Address Data: ${data['address']}');
      final user = User(
        id: widget.user.id,
        user: data['user'],
        address: data['address'],
      );
      response = await apiHandler.updateUser(id: widget.user.id, user: user);
    }
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(" Edit Page"),
          centerTitle: true,
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
        bottomNavigationBar: MaterialButton(
          onPressed: updateData,
          color: Colors.teal,
          textColor: Colors.white,
          padding: const EdgeInsets.all(20),
          child: const Text('Update'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: FormBuilder(
            key: _formKey,
            initialValue: {
              'user': widget.user.user,
              'address': widget.user.address,
            },
            child: Column(children: [
              FormBuilderTextField(
                  name: 'user',
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ])),
              const SizedBox(height: 20),
              FormBuilderTextField(
                  name: 'address',
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]))
            ]),
          ),
        ));
  }
}
