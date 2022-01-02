import 'package:pangolin/utils/extensions/extensions.dart';

class SettingsCard extends StatelessWidget {
  final List<Widget>? children;

  const SettingsCard({Key? key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        color: Theme.of(context).cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            color: Theme.of(context).darkMode
                ? Colors.white.withOpacity(0.05)
                : Colors.black.withOpacity(0.05),
            width: 2,
          ),
        ),
        child: ListTileTheme.merge(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 28.0,
            vertical: 4.0,
          ),
          child: ListView(
            shrinkWrap: true,
            children: children?.toList().joinType(
                      const Divider(
                        indent: 2,
                        endIndent: 2,
                        height: 2,
                      ),
                    ) ??
                [],
          ),
        ),
      ),
    );
  }
}

extension JoinList<T> on List<T> {
  List<T> joinType(T separator) {
    final List<T> workList = [];

    for (int i = 0; i < (length * 2) - 1; i++) {
      if (i.isEven) {
        workList.add(this[i ~/ 2]);
      } else {
        workList.add(separator);
      }
    }

    return workList;
  }
}
