// import 'package:flutter/material.dart';
// import 'package:flutter_cube/flutter_cube.dart';
//
// class Plot3DScreen extends StatelessWidget {
//   final Map<String, dynamic> surfaceLocation;
//   final List<Map<String, dynamic>> targets;
//
//   const Plot3DScreen({
//     super.key,
//     required this.surfaceLocation,
//     required this.targets,
//   });
//
//   List<Vector3> generate3DPoints() {
//     final points = <Vector3>[];
//
//     // Add the surface location as the first point
//     points.add(Vector3(
//       double.parse(surfaceLocation['east']),
//       double.parse(surfaceLocation['tvd']),
//       double.parse(surfaceLocation['north']),
//     ));
//
//     // Add target locations
//     for (var target in targets) {
//       points.add(Vector3(
//         double.parse(target['east']),
//         double.parse(target['tvd']),
//         double.parse(target['north']),
//       ));
//     }
//
//     return points;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final points = generate3DPoints();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('3D Plot'),
//       ),
//       body: Cube(
//         onSceneCreated: (Scene scene) {
//           scene.world.add(Object(
//             name: "3D Points",
//             position: Vector3(0, 0, 0),
//             scale: Vector3(1, 1, 1),
//             lighting: true,
//             mesh: Mesh(
//               vertices: points,
//               indices: List.generate(points.length, (index) => index),
//             ),
//           ));
//           scene.camera.zoom = 10;
//         },
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_cube/flutter_cube.dart';
//
// class Plot3DScreen extends StatelessWidget {
//   final Map<String, dynamic> surfaceLocation;
//   final List<Map<String, dynamic>> targets;
//
//   const Plot3DScreen({
//     super.key,
//     required this.surfaceLocation,
//     required this.targets,
//   });
//
//   List<Vector3> generate3DPoints() {
//     final points = <Vector3>[];
//
//     // Add the surface location as the first point
//     points.add(Vector3(
//       double.parse(surfaceLocation['east']),
//       double.parse(surfaceLocation['tvd']),
//       double.parse(surfaceLocation['north']),
//     ));
//
//     // Add target locations
//     for (var target in targets) {
//       points.add(Vector3(
//         double.parse(target['east']),
//         double.parse(target['tvd']),
//         double.parse(target['north']),
//       ));
//     }
//
//     return points;
//   }
//
//   List<Polygon> generatePolygons(int vertexCount) {
//     final polygons = <Polygon>[];
//     for (var i = 0; i < vertexCount - 2; i++) {
//       polygons.add(Polygon([
//         i,
//         i + 1,
//         i + 2,
//       ]));
//     }
//     return polygons;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final points = generate3DPoints();
//     final polygons = generatePolygons(points.length);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('3D Plot'),
//       ),
//       body: Cube(
//         onSceneCreated: (Scene scene) {
//           scene.world.add(Object(
//             name: "3D Points",
//             position: Vector3(0, 0, 0),
//             scale: Vector3(1, 1, 1),
//             lighting: true,
//             mesh: Mesh(
//               vertices: points,
//               indices: polygons,
//             ),
//           ));
//           scene.camera.zoom = 10;
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_cube/flutter_cube.dart';
//
// class Plot3DScreen extends StatelessWidget {
//   final Map<String, dynamic> surfaceLocation;
//   final List<Map<String, dynamic>> targets;
//
//   const Plot3DScreen({
//     super.key,
//     required this.surfaceLocation,
//     required this.targets,
//   });
//
//   List<Vector3> generate3DPoints() {
//     final points = <Vector3>[];
//
//     // Add the surface location as the first point
//     points.add(Vector3(
//       double.parse(surfaceLocation['east']),
//       double.parse(surfaceLocation['tvd']),
//       double.parse(surfaceLocation['north']),
//     ));
//
//     // Add target locations
//     for (var target in targets) {
//       points.add(Vector3(
//         double.parse(target['east']),
//         double.parse(target['tvd']),
//         double.parse(target['north']),
//       ));
//     }
//
//     return points;
//   }
//
//   // List<Polygon> generatePolygons(int vertexCount) {
//   //   final polygons = <Polygon>[];
//   //   for (var i = 0; i < vertexCount - 1; i++) {
//   //     polygons.add(Polygon([i, i + 1]));
//   //   }
//   //   return polygons;
//   // }
//
//   List<int> generateLineIndices(int vertexCount) {
//     final indices = <int>[];
//     for (var i = 0; i < vertexCount - 1; i++) {
//       indices.addAll([i, i + 1]);  // Connecting each point to the next
//     }
//     return indices;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final points = generate3DPoints();
//     final indices = generateLineIndices(points.length);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('3D Plot'),
//       ),
//       body: Cube(
//         onSceneCreated: (Scene scene) {
//           scene.world.add(Object(
//             name: "3D Points",
//             position: Vector3(0, 0, 0),
//             scale: Vector3(1, 1, 1),
//             lighting: true,
//             mesh: Mesh(
//               vertices: points,
//               indices: indices,
//             ),
//           ));
//           scene.camera.zoom = 10;
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Plot3DScreen extends StatelessWidget {
  final Map<String, dynamic> surfaceLocation;
  final List<Map<String, dynamic>> targets;

  const Plot3DScreen({
    super.key,
    required this.surfaceLocation,
    required this.targets,
  });

  // Function to generate 3D points from input data
  List<Vector3> generate3DPoints() {
    final points = <Vector3>[];

    // Add the surface location as the first point
    points.add(Vector3(
      double.parse(surfaceLocation['east']),
      double.parse(surfaceLocation['tvd']),
      double.parse(surfaceLocation['north']),
    ));

    // Add target locations
    for (var target in targets) {
      points.add(Vector3(
        double.parse(target['east']),
        double.parse(target['tvd']),
        double.parse(target['north']),
      ));
    }

    print('Generated Points: $points');
    return points;
  }

  // Function to generate polygons (triangles) from points
  List<Polygon> generatePolygons(int vertexCount) {
    final polygons = <Polygon>[];

    // Check if vertexCount is sufficient to form at least one triangle
    if (vertexCount < 3) {
      print("Not enough vertices to form a polygon. Vertex count: $vertexCount");
      return polygons;
    }

    // Ensure at least three points to form a triangle
    for (var i = 0; i < vertexCount - 2; i++) {
      polygons.add(Polygon(i, i + 1, i + 2));
    }

    print("Generated polygons: ${polygons[0]}");
    return polygons;
  }

  // Function to create a simple cube mesh for debugging
  Object createDebugCube() {
    final vertices = [
      Vector3(-0.5, -0.5, -0.5),
      Vector3(0.5, -0.5, -0.5),
      Vector3(0.5, 0.5, -0.5),
      Vector3(-0.5, 0.5, -0.5),
      Vector3(-0.5, -0.5, 0.5),
      Vector3(0.5, -0.5, 0.5),
      Vector3(0.5, 0.5, 0.5),
      Vector3(-0.5, 0.5, 0.5),
    ];

    final polygons = [
      Polygon(0, 1, 2),
      Polygon(0, 2, 3),
      Polygon(4, 5, 6),
      Polygon(4, 6, 7),
      Polygon(0, 1, 5),
      Polygon(0, 5, 4),
      Polygon(2, 3, 7),
      Polygon(2, 7, 6),
      Polygon(0, 3, 7),
      Polygon(0, 7, 4),
      Polygon(1, 2, 6),
      Polygon(1, 6, 5),
    ];

    return Object(
      name: "debugCube",
      position: Vector3(0, 0, 0),
      scale: Vector3(1, 1, 1),
      mesh: Mesh(
        vertices: vertices,
        indices: polygons,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final points = generate3DPoints();
    final polygons = generatePolygons(points.length);

    return Scaffold(
      appBar: AppBar(
        title: const Text('3D Plot'),
      ),
      body: Cube(
        onSceneCreated: (Scene scene) {
          // Add the 3D points and polygons
          scene.world.add(Object(
            name: "3D Points",
            position: Vector3(0, 0, 0),
            scale: Vector3(1, 1, 1),
            lighting: true,
            mesh: Mesh(
              vertices: points,
              indices: polygons,
            ),
          ));

          // Debugging: Add a manually created cube to ensure rendering is working
          scene.world.add(createDebugCube());

          // Adjust camera properties (e.g., zoom)
          scene.camera.zoom = 10;
          // scene.camera.target = Vector3(0, 0, 0); // Focus on the origin
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_cube/flutter_cube.dart';
// import 'package:vector_math/vector_math_64.dart';

// class Polygon {
//   final int vertex1;
//   final int vertex2;
//   final int vertex3;
//
//   Polygon(this.vertex1, this.vertex2, this.vertex3);
//
//   @override
//   String toString() {
//     return 'Polygon($vertex1, $vertex2, $vertex3)';
//   }
// }

// class Plot3DScreen extends StatelessWidget {
//   final Map<String, dynamic> surfaceLocation;
//   final List<Map<String, dynamic>> targets;
//
//   const Plot3DScreen({
//     super.key,
//     required this.surfaceLocation,
//     required this.targets,
//   });
//
//   // Function to generate 3D points from input data
//   List<Vector3> generate3DPoints() {
//     final points = <Vector3>[];
//
//     // Add the surface location as the first point
//     points.add(Vector3(
//       double.parse(surfaceLocation['east']),
//       double.parse(surfaceLocation['tvd']),
//       double.parse(surfaceLocation['north']),
//     ));
//
//     // Add target locations
//     for (var target in targets) {
//       points.add(Vector3(
//         double.parse(target['east']),
//         double.parse(target['tvd']),
//         double.parse(target['north']),
//       ));
//     }
//
//     print('Generated Points: $points');
//     return points;
//   }
//
//   // Function to generate polygons (triangles) from points
//   List<Polygon> generatePolygons(int vertexCount) {
//     final polygons = <Polygon>[];
//
//     // Check if vertexCount is sufficient to form at least one triangle
//     if (vertexCount < 3) {
//       print("Not enough vertices to form a polygon. Vertex count: $vertexCount");
//       return polygons;
//     }
//
//     // Ensure at least three points to form a triangle
//     for (var i = 0; i < vertexCount - 2; i++) {
//       polygons.add(Polygon(i, i + 1, i + 2));
//     }
//
//     print("Generated polygons: $polygons");
//     return polygons;
//   }
//
//   // Function to create a simple cube mesh for debugging
//     // Function to create a simple cube mesh for debugging
//   Object createDebugCube() {
//     final vertices = [
//       Vector3(-0.5, -0.5, -0.5),
//       Vector3(0.5, -0.5, -0.5),
//       Vector3(0.5, 0.5, -0.5),
//       Vector3(-0.5, 0.5, -0.5),
//       Vector3(-0.5, -0.5, 0.5),
//       Vector3(0.5, -0.5, 0.5),
//       Vector3(0.5, 0.5, 0.5),
//       Vector3(-0.5, 0.5, 0.5),
//     ];
//
//     final polygons = [
//       Polygon(0, 1, 2),
//       Polygon(0, 2, 3),
//       Polygon(4, 5, 6),
//       Polygon(4, 6, 7),
//       Polygon(0, 1, 5),
//       Polygon(0, 5, 4),
//       Polygon(2, 3, 7),
//       Polygon(2, 7, 6),
//       Polygon(0, 3, 7),
//       Polygon(0, 7, 4),
//       Polygon(1, 2, 6),
//       Polygon(1, 6, 5),
//     ];
//
//     return Object(
//       name: "debugCube",
//       position: Vector3(0, 0, 0),
//       scale: Vector3(1, 1, 1),
//       mesh: Mesh(
//         vertices: vertices,
//         indices: polygons,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final points = generate3DPoints();
//     final polygons = generatePolygons(points.length);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('3D Plot'),
//       ),
//       body: Cube(
//         onSceneCreated: (Scene scene) {
//           // Add the 3D points and polygons
//           scene.world.add(Object(
//             name: "3D Points",
//             position: Vector3(0, 0, 0),
//             scale: Vector3(1, 1, 1),
//             lighting: true,
//             mesh: Mesh(
//               vertices: points,
//               indices: polygons,
//             ),
//           ));
//
//           // Debugging: Add a manually created cube to ensure rendering is working
//           scene.world.add(createDebugCube());
//
//           // Adjust camera properties (e.g., zoom)
//           scene.camera.zoom = 10;
//           // scene.camera.target = Vector3(0, 0, 0); // Focus on the origin
//         },
//       ),
//     );
//   }
// }






