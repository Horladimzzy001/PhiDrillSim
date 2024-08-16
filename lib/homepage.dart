import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _northController = TextEditingController();
  final TextEditingController _eastController = TextEditingController();
  final TextEditingController _tvdController = TextEditingController();

  List<Map<String, TextEditingController>> targets = [];

  void handleAddTarget() {
    setState(() {
      targets.add({
        'north': TextEditingController(),
        'east': TextEditingController(),
        'tvd': TextEditingController(),
      });
    });
  }

  void handleRemoveTarget(int index) {
    setState(() {
      targets.removeAt(index);
    });
  }

  void handlePlan() {
    if (_northController.text.isEmpty ||
        _eastController.text.isEmpty ||
        _tvdController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Validation Error"),
            content: Text("Please fill in all Surface Location fields."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    if (targets.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Validation Error"),
            content: Text("Please add at least one Target Location."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    for (int i = 0; i < targets.length; i++) {
      if (targets[i]['north']!.text.isEmpty ||
          targets[i]['east']!.text.isEmpty ||
          targets[i]['tvd']!.text.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Validation Error"),
              content:
                  Text("Please fill in all fields for Target ${i + 1}."),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }
    }

    // If validation is successful, navigate to a new route with the data
    Navigator.pushNamed(context, '/CalculationTable', arguments: {
      'surfaceLocation': {
        'north': _northController.text,
        'east': _eastController.text,
        'tvd': _tvdController.text,
      },
      'targets': targets.map((target) {
        return {
          'north': target['north']!.text,
          'east': target['east']!.text,
          'tvd': target['tvd']!.text,
        };
      }).toList(),
    });
  }

  @override
  void dispose() {
    _northController.dispose();
    _eastController.dispose();
    _tvdController.dispose();
    targets.forEach((target) {
      target['north']!.dispose();
      target['east']!.dispose();
      target['tvd']!.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Directional Survey Methods"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Surface Location',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _northController,
                    decoration: InputDecoration(
                      labelText: "N (ft)",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: _eastController,
                    decoration: InputDecoration(
                      labelText: "E (ft)",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: _tvdController,
                    decoration: InputDecoration(
                      labelText: "TVD (ft)",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Column(
              children: targets.map((target) {
                int index = targets.indexOf(target);
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: target['north']!,
                        decoration: InputDecoration(
                          labelText: "Target ${index + 1} N (ft)",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        controller: target['east']!,
                        decoration: InputDecoration(
                          labelText: "E (ft)",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        controller: target['tvd']!,
                        decoration: InputDecoration(
                          labelText: "TVD (ft)",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => handleRemoveTarget(index),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: handleAddTarget,
                  child: Text("Add Target"),
                ),
                ElevatedButton(
                  onPressed: handlePlan,
                  child: Text("Plan"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}