import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tswork/components/app_colors.dart';
import 'package:tswork/components/ctrl_zy.dart';







final drawingPointsProvider =
    StateNotifierProvider<PointsNotifier, List<Offset?>>(
        (ref) => PointsNotifier());

final drawingLinesProvider =
    StateNotifierProvider<LinesNotifier, List<List<List<Offset>>>>(
        (ref) => LinesNotifier());

class PointsNotifier extends StateNotifier<List<Offset?>> {
  PointsNotifier() : super([]);

  void addPoint(Offset point) {
    state = [...state, point];
  }

  void endDrawing() {
    state = [...state, null];
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final points = ref.watch(drawingPointsProvider);
    // final points = ref.watch(drawingLinesProvider);
    final lines = ref.watch(drawingLinesProvider);

    // final lines = ref.watch(drawingLinesProvider);
    return Scaffold(
      backgroundColor: AppColors.notgrey,
      body: Stack(
        children: [
          for (var i = 0; i <= MediaQuery.of(context).size.width; i += 30)
            for (var j = 0; j <= MediaQuery.of(context).size.height; j += 30)
              Positioned(
                top: j.toDouble(),
                left: i.toDouble(),
                child: Container(
                  width: MediaQuery.of(context).size.width / 80,
                  height: MediaQuery.of(context).size.width / 80,
                  decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          GestureDetector(
            onPanStart: (DragStartDetails details) {
              ref
                  .read(drawingLinesProvider.notifier)
                  .addPoint(details.localPosition);
            },
            onPanUpdate: (DragUpdateDetails details) {
              ref
                  .read(drawingLinesProvider.notifier)
                  .addPoint(details.localPosition);
            },
            onPanEnd: (DragEndDetails details) {
              ref.read(drawingLinesProvider.notifier).endDrawing();
            },
            child: CustomPaint(
              painter: LinePainter(lines),
              child: Container(),
            ),
          ),

          
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Stack(
              children: [
                Positioned(
                  top: 45,
                  left: 8,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.31),
                        color: AppColors.mawhite),
                    width: 80.23,
                    height: 31,
                    child: Row(
                      children: [
                      Flexible(
  child: Consumer(
    builder: (context, ref, child) {
      return IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.iconColor,
        ),
        onPressed: () {
          ref.read(drawingLinesProvider.notifier).undo();
        },
      );
    },
  ),
),
Flexible(
  child: Consumer(
    builder: (context, ref, child) {
      return IconButton(
        icon: Icon(
          Icons.arrow_forward,
          color: AppColors.iconColor,
        ),
        onPressed: () {
          ref.read(drawingLinesProvider.notifier).redo();
        },
      );
    },
  ),
),

                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 700,
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        height: 52,
                        width: 359,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: AppColors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, top: 7),
                          child: Text(
                            'Нажмите на любую точку экрана, чтобы построить угол',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 70,
                              width: 360,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                width: 336,
                                height: 46.5,
                                decoration: BoxDecoration(
                                    color: AppColors.notgrey,
                                    borderRadius: BorderRadius.circular(11)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.cancel,
                                      color: AppColors.naturalGray,
                                      size: 13.5,
                                    ),
                                    Text(
                                      'Отменить действие',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: AppColors.naturalGray),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class LinePainter extends CustomPainter {
  final List<List<List<Offset>>> lines;

  LinePainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    for (var line in lines) {
      for (var i = 0; i < line.length - 1; i++) {
        if (line[i] != null && line[i + 1] != null)
          canvas.drawLine(line[i][0], line[i + 1][0], paint);
      }
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}








