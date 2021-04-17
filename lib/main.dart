import 'package:base64_analyze/base64_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Base64 Analyzer',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final inputController = new TextEditingController();
  final outputController = new TextEditingController();
  bool isEncode = true;
  String output = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Base64 Analyzer'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {

              });
              resetText();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: new EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Wrap(
                children: [
                  ChoiceChip(
                    selected: (isEncode),
                    onSelected: (value) {
                      isEncode = true;
                      setState(() {
                        resetText();
                      });
                    },
                    label: Text('Encode'),
                  ),
                  SizedBox(width: 16,),
                  ChoiceChip(
                    selected: (!isEncode),
                    onSelected: (value) {
                      isEncode = false;
                      setState(() {
                        resetText();
                      });
                    },
                    label: Text('Decode'),
                  ),
                ],
              ),
              SizedBox(height: 32,),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: inputController,
                decoration: InputDecoration(
                    hintText: 'Input here',
                    labelText: 'Input',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.paste_outlined),
                      onPressed: () async {
                        ClipboardData clipboard = await Clipboard.getData('text/plain');
                        inputController.text = clipboard.text;
                        onInputChanged(inputController.text);
                      },
                    )
                ),
                onChanged: (text) {
                  setState(() {
                    onInputChanged(text);
                  });
                },
              ),
              SizedBox(height: 32,),
              Icon(Icons.arrow_downward, color: Theme.of(context).primaryColor,),
              SizedBox(height: 32,),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: outputController,
                decoration: InputDecoration(
                    labelText: 'Output',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.copy_outlined),
                      onPressed: () {
                        //Copy
                        Clipboard.setData(ClipboardData(text: output,));
                      },
                    )
                ),
                onChanged: (text) {
                  outputController.text = output;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onInputChanged(String text) {
    output = (isEncode) ? Base64Controller.encodeBase64(text) : Base64Controller.decodeBase64(text);
    outputController.text = output;
  }

  void resetText() {
    inputController.text = "";
    output = "";
    outputController.text = "";
  }
}
