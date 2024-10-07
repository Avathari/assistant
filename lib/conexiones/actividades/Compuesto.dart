
import 'package:flutter/material.dart';


/// Represents the XlsIO widget class.
class CreateExcelWidget extends StatelessWidget {
  const CreateExcelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CreateExcelStatefulWidget(title: 'Create Excel document'),
    );
  }
}

/// Represents the XlsIO stateful widget class.
class CreateExcelStatefulWidget extends StatefulWidget {
  /// Initalize the instance of the [CreateExcelStatefulWidget] class.
  const CreateExcelStatefulWidget({super.key, required this.title});

  /// title.
  final String title;
  @override
  // ignore: library_private_types_in_public_api
  _CreateExcelState createState() => _CreateExcelState();
}

class _CreateExcelState extends State<CreateExcelStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
              onPressed: () async {
                // ExcelApi.generateExcel();
              },
              child: const Text('Generate Excel'),
            )
          ],
        ),
      ),
    );
  }
}
