import 'package:pangolin/utils/data/database_manager.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/widgets/global/box/box_container.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool showAtStartup = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: BoxSurface(
        borderRadius: context.commonData.borderRadiusBig,
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 3.75,
          vertical: MediaQuery.of(context).size.height / 4.5,
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logos/pangolin.png", scale: 8),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Welcome to Pangolin!",
                style: TextStyle(fontSize: 28),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Note: This is a pre release version of the Desktop. Some features may not work properly yet.",
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: showAtStartup,
                    onChanged: (val) {
                      setState(() {
                        showAtStartup = !showAtStartup;
                      });
                    },
                  ),
                  const Text("Show at every startup"),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  DatabaseManager.set("initialStart", showAtStartup);

                  Navigator.pop(context);
                },
                child: Padding(
                  padding: ThemeConstants.buttonPadding,
                  child: const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
