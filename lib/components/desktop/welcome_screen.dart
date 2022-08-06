import 'package:pangolin/services/customization.dart';
import 'package:pangolin/utils/data/constants.dart';
import 'package:pangolin/utils/extensions/extensions.dart';
import 'package:pangolin/widgets/services.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with StateServiceListener<CustomizationService, WelcomeScreen> {
  bool showAtStartup = true;

  @override
  Widget buildChild(BuildContext context, CustomizationService service) {
    final bool darkMode = service.darkMode;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.transparent,
        child: Center(
          child: Container(
            decoration: ShapeDecoration(
              color: darkMode ? const Color(0xFF1E1E1E) : Colors.white,
              shape: Constants.mediumShape,
            ),
            clipBehavior: Clip.antiAlias,
            width: 640,
            height: 480,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    darkMode
                        ? 'assets/images/other/developer-dark.png'
                        : 'assets/images/other/developer-white.png',
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    height: 256,
                    width: 256,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 40,
                  child: Image.asset(
                    darkMode
                        ? 'assets/images/logos/dahliaOS-white.png'
                        : 'assets/images/logos/dahliaOS-modern.png',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    height: 32,
                  ),
                ),
                Positioned(
                  top: 132,
                  left: 40,
                  width: 368,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome!",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w100,
                          fontFamily: "Roboto",
                        ),
                      ),
                      Text(
                        "\nFor now, dahliaOS is pre-release software. Some features are incomplete, applications may not work as expected, and the experience may not be stable on certain devices. \n\nWe are always looking to improve our software, so feel free to share feedback with us on any of our social media. Have fun!",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 30,
                  child: Row(
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
                ),
                Positioned(
                  bottom: 30,
                  right: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      service.showWelcomeScreen = showAtStartup;

                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: ThemeConstants.buttonPadding,
                      child: const Text("LET'S GO!"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
