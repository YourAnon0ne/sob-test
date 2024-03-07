// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class MoveableArrow extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final x = watch(xProvider);
//     final y = watch(yProvider);

//     return Stack(
//       children: [
//         Positioned(
//           top: y.state,
//           left: x.state,
//           child: GestureDetector(
//             onPanUpdate: (details) {
//               x.state += details.delta.dx;
//               y.state += details.delta.dy;
//             },
//             child: CustomPaint(
//               painter: ArrowPainter(),
//               size: Size(100, 100),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// final xProvider = StateProvider((ref) => 8.0);
// final yProvider = StateProvider((ref) => 45.0);

// class ArrowPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue
//       ..strokeWidth = 2.0
//       ..strokeCap = StrokeCap.round;

//     final center = Offset(size.width / 2, size.height / 2);
//     final arrowLength = 40.0;
//     final arrowWidth = 20.0;

//     canvas.drawLine(center, Offset(center.dx, center.dy - arrowLength), paint);

//     final path = Path()
//       ..moveTo(center.dx - arrowWidth / 2, center.dy - arrowLength)
//       ..lineTo(center.dx + arrowWidth / 2, center.dy - arrowLength)
//       ..lineTo(center.dx, center.dy - arrowLength - arrowWidth)
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
