import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class DashboardStats extends StatefulWidget {
  const DashboardStats({super.key});

  @override
  State<DashboardStats> createState() => _DashboardStatsState();
}

class _DashboardStatsState extends State<DashboardStats> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: global.containerWidth(context),
          height: global.height(context) * .3625 + 40,
          padding: const EdgeInsets.all(19),
          decoration: global.boxDecoration(context),
          child: Column(
            children: [
              const ChartTitle(),
              SizedBox(
                height: global.height(context) * .0125,
              ),
              const ChartBody()
            ],
          ),
        )
      ],
    );
  }
}

class ChartTitle extends StatelessWidget {
  const ChartTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: Container(
            height: global.height(context) * .05,
            width: double.infinity,
            padding: EdgeInsets.only(
              left: global.width(context) * .02,
            ),
            alignment: Alignment.center,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(global.borderRadius - 10),
              boxShadow: global.shadow(context),
              border: Border.all(color: Colors.white),
            ),
            child: const Text(
              'Select Exercise',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const Flexible(
          flex: 4,
          child: SizedBox(
            child: Text(
              'Friends',
              style: TextStyle(color: Colors.white, fontSize: 45),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            height: global.height(context) * .05,
            width: double.infinity,
            padding: EdgeInsets.only(
              left: global.width(context) * .025,
            ),
            alignment: Alignment.center,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(global.borderRadius - 10),
              boxShadow: global.shadow(context),
              border: Border.all(color: Colors.white),
            ),
            child: const Row(
              children: [
                 Text(
                  'Select Rep-Range',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChartBody extends StatelessWidget {
  const ChartBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          gradient: global.linearGradient,
          borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: global.height(context) * .3,
        width: global.containerWidth(context),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15),
        ),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 11,
            minY: 0,
            maxY: 6,
            titlesData: const FlTitlesData(
              show: false,
            ),
            lineTouchData: LineTouchData(
              enabled: true,
              getTouchedSpotIndicator:
                  (LineChartBarData barData, List<int> indicators) {
                return indicators.map(
                  (int index) {
                    const line = FlLine(
                      color: Colors.white,
                      strokeWidth: 2,
                      dashArray: [2, 4],
                    );
                    return const TouchedSpotIndicatorData(
                      line,
                      FlDotData(show: false),
                    );
                  },
                ).toList();
              },
              getTouchLineEnd: (_, __) => double.infinity,
              touchTooltipData: LineTouchTooltipData(
                tooltipBorder: const BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
                getTooltipColor: (touchedSpot) => global.darkGrey,
                tooltipRoundedRadius: 15,
                tooltipPadding: EdgeInsets.symmetric(
                    horizontal: global.width(context) * .025,
                    vertical: global.height(context) * .01),
                fitInsideHorizontally: true,
                fitInsideVertically: true,
              ),
            ),
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Theme.of(context).colorScheme.surface.withOpacity(.5),
                  strokeWidth: 1,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Theme.of(context).colorScheme.surface.withOpacity(.5),
                  strokeWidth: 1,
                );
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 3),
                  FlSpot(2.6, 2),
                  FlSpot(4.9, 5),
                  FlSpot(6.8, 2.5),
                  FlSpot(8, 4),
                  FlSpot(9.5, 3),
                  FlSpot(11, 4),
                ],
                isCurved: true,
                gradient: global.linearGradient,
                barWidth: 1,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color(0xffa4fba4).withOpacity(.8),
                      const Color(0xfff2f58d).withOpacity(.8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
