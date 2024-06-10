import 'package:flutter/material.dart';
import 'package:todo_app/modal/task.dart';
import 'package:todo_app/ui/utils/size_config.dart';
import 'package:todo_app/utils.dart';

class TaskTile extends StatelessWidget {
  TaskTile(this.task, {Key? key}) : super(key: key);

  Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
              SizeConfig.orientation == Orientation.landscape ? 4 : 20)),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        width: SizeConfig.orientation == Orientation.landscape
            ? SizeConfig.screenWidth / 2
            : SizeConfig.screenWidth,
        child: Container(
          padding: EdgeInsets.all(getProportionateScreenHeight(8)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: _getBGClr(task.color)),
          child: Row(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${task.startTime} - ${task.endTime}',
                          style: TextStyle(
                            color: Colors.grey[100],
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      task.note ?? '',
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              )),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                width: 0.5,
                color: Colors.grey[200]!.withOpacity(0.7),
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  task.isCompleted == 1 ? 'COMPLETED' : 'TODO',
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBGClr(int? color) {
    switch (color) {
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;

      default:
        return bluishClr;
    }
  }
}
