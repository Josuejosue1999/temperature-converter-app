import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _controller = TextEditingController();
  String _conversionType = 'F to C';
  String _result = '';
  List<String> _history = [];

  void _convert() {
    double input = double.tryParse(_controller.text) ?? 0.0;
    double output;

    if (_conversionType == 'F to C') {
      output = (input - 32) * 5 / 9;
      _history.insert(0, 'F to C: $input°F => ${output.toStringAsFixed(1)}°C');
    } else {
      output = input * 9 / 5 + 32;
      _history.insert(0, 'C to F: $input°C => ${output.toStringAsFixed(1)}°F');
    }

    setState(() {
      _result = output.toStringAsFixed(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Temperature Converter',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF800020), // Wine red color
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: 'F to C',
                      groupValue: _conversionType,
                      onChanged: (value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                    Flexible(child: Text('Fahrenheit to Celsius')),
                    Radio<String>(
                      value: 'C to F',
                      groupValue: _conversionType,
                      onChanged: (value) {
                        setState(() {
                          _conversionType = value!;
                        });
                      },
                    ),
                    Flexible(child: Text('Celsius to Fahrenheit')),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Enter temperature',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '=',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Text(
                          _result,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _convert,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xFF800020)), // Wine red color
                  ),
                  child: Text(
                    'Convert',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: _history.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_history[index]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
