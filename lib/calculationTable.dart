import 'package:flutter/material.dart';
//import 'package:share_plus/share_plus.dart';
import 'dart:math';
import 'dart:convert';

class CalculationTable extends StatelessWidget {
  final Map<String, dynamic> surfaceLocation = {};
  final List<Map<String, dynamic>> targets = [];

  

  List<Map<String, double>> get combinedLocations {
    return [
      {
        'north': double.parse(surfaceLocation['north']),
        'east': double.parse(surfaceLocation['east']),
        'tvd': double.parse(surfaceLocation['tvd']),
      },
      ...targets.map((target) {
        return {
          'north': double.parse(target['north']),
          'east': double.parse(target['east']),
          'tvd': double.parse(target['tvd']),
        };
      }).toList(),
    ];
  }

  double calculateKOP(double x, double y, double tvd, {double buildRate = 2}) {
    final hd = sqrt(x * x + y * y);
    final md = sqrt(tvd * tvd + hd * hd);
    final inclinationAngle = atan(hd / tvd) * (180 / pi);
    final mdInclined = (inclinationAngle / buildRate) * 100;
    final kop = md - mdInclined;
    return kop;
  }

  List<Map<String, double>> calculateMIAforLocations(
      List<Map<String, double>> locations) {
    final results = <Map<String, double>>[];

    for (var i = 0; i < locations.length; i++) {
      final current = locations[i];

      if (i == 0) {
        results.add({
          'measuredDepth': sqrt(current['north']! * current['north']! +
              current['east']! * current['east']! +
              current['tvd']! * current['tvd']!),
          'inclination': 0,
          'azimuth': 0,
        });
      } else {
        final previous = locations[i - 1];
        final deltaN = current['north']! - previous['north']!;
        final deltaE = current['east']! - previous['east']!;
        final deltaTVD = current['tvd']! - previous['tvd']!;
        final measuredDepth =
            sqrt(deltaN * deltaN + deltaE * deltaE + deltaTVD * deltaTVD);
        final horizontalDisplacement = sqrt(deltaN * deltaN + deltaE * deltaE);
        final inclination =
            atan2(horizontalDisplacement, deltaTVD) * (180 / pi);
        var azimuth = atan2(deltaE, deltaN) * (180 / pi);

        if (azimuth < 0) {
          azimuth += 360;
        }

        if (i == 1) {
          azimuth = applyEtajeMapping(azimuth);
        }

        results.add({
          'measuredDepth': measuredDepth,
          'inclination': inclination,
          'azimuth': azimuth,
        });
      }
    }

    return results;
  }

  double applyEtajeMapping(double azimuth) {
    if (azimuth >= 0 && azimuth <= 120) {
      return 1.5 * azimuth;
    } else if (azimuth >= 240 && azimuth <= 360) {
      return 1.5 * azimuth - 180;
    } else {
      return azimuth;
    }
  }

  String convertToCSV(List<Map<String, double>> miaResults) {
    if (miaResults.isEmpty) {
      return '';
    }

    final header = 'Point,MD (ft),Inclination (°),Azimuth (°)\n';
    final csvRows = miaResults.asMap().entries.map((entry) {
      final index = entry.key;
      final mia = entry.value;
      return '${index + 1},${mia['measuredDepth']!.toStringAsFixed(2)},${mia['inclination']!.toStringAsFixed(2)},${mia['azimuth']!.toStringAsFixed(2)}';
    }).toList();

    return header + csvRows.join('\n');
  }

  void handleExport(List<Map<String, double>> miaResults) async {
    final csvData = convertToCSV(miaResults);
    if (csvData.isNotEmpty) {
      final base64String = base64Encode(utf8.encode(csvData));
      //// await Share.share('data:text/csv;base64,$base64String',
      //   subject: 'MIA Results');
    } else {
      print("No CSV data to share.");
    }
  }

  void handlePlot3D(BuildContext context) {
    if (surfaceLocation['north'] == '' ||
        surfaceLocation['east'] == '' ||
        surfaceLocation['tvd'] == '') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Validation Error"),
          content: Text("Please fill in all Surface Location fields."),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            )
          ],
        ),
      );
      return;
    }

    if (targets.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Validation Error"),
          content: Text("Please add at least one Target Location."),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            )
          ],
        ),
      );
      return;
    }

    Navigator.pushNamed(context, '/plot3d',
        arguments: {'surfaceLocation': surfaceLocation, 'targets': targets});
  }

  @override
  Widget build(BuildContext context) {
    final kop = calculateKOP(
      double.parse(surfaceLocation['east']) - double.parse(targets[0]['east']),
      double.parse(surfaceLocation['north']) -
          double.parse(targets[0]['north']),
      double.parse(targets[0]['tvd']),
    );

    final miaResults = calculateMIAforLocations(combinedLocations);

    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis Breakdown'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => handleExport(miaResults),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLocationTable(),
            SizedBox(height: 16.0),
            buildKOPDisplay(kop),
            SizedBox(height: 16.0),
            buildMIAResultsTable(miaResults),
            SizedBox(height: 16.0),
            buildPlot3DButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildLocationTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          buildTableHeader(['Location', 'N (ft)', 'E (ft)', 'TVD (ft)']),
          buildTableRow('Surface Location', surfaceLocation),
          ...targets.asMap().entries.map((entry) {
            final index = entry.key;
            final target = entry.value;
            return buildTableRow('Target ${index + 1}', target);
          }).toList(),
        ],
      ),
    );
  }

  Widget buildKOPDisplay(double kop) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          'Calculated Kick-Off Point (KOP): ${kop.toStringAsFixed(2)} feet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildMIAResultsTable(List<Map<String, double>> miaResults) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          buildTableHeader(['Location', 'MD (ft)', 'I (°)', 'A (°)']),
          ...miaResults.asMap().entries.map((entry) {
            final index = entry.key;
            final mia = entry.value;
            return buildTableRow('Location ${index + 1}', mia, isMIA: true);
          }).toList(),
        ],
      ),
    );
  }

  Widget buildTableHeader(List<String> headers) {
    return Container(
      color: Colors.grey[300],
      child: Row(
        children: headers.map((header) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                header,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildTableRow(String label, Map<String, dynamic> data,
      {bool isMIA = false}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(label),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(isMIA
                ? data['measuredDepth'].toStringAsFixed(2)
                : data['north'].toString()),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(isMIA
                ? data['inclination'].toStringAsFixed(2)
                : data['east'].toString()),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(isMIA
                ? data['azimuth'].toStringAsFixed(2)
                : data['tvd'].toString()),
          ),
        ),
      ],
    );
  }

  Widget buildPlot3DButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => handlePlot3D(context),
      child: Center(
        child: Text(
          'Plot 3D Graph',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
