import 'package:flutter/material.dart';
import 'package:horno/pages/index.dart';

import '../routes/index.dart';
// import 'package:horno/widgets/index.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: data.length,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (context, index) => CustomOnboarding(
                  image: data[index].image,
                  title: data[index].title,
                  descripcion: data[index].descripcion,
                ),
              ),
            ),
            Row(
              children: [
                ...List.generate(
                  data.length,
                  (index) => Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: puntos(
                        isActive: index == _pageIndex,
                      )),
                ),
                const Spacer(),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                    style:
                        ElevatedButton.styleFrom(shape: const CircleBorder()),
                    child: const Icon(Icons.next_plan),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

class puntos extends StatelessWidget {
  const puntos({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      height: isActive ? 12 : 4,
      width: isActive ? 12 : 4,
      decoration: BoxDecoration(
        color: isActive ? Colors.yellow : Colors.yellow[700],
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    );
  }
}

class Onboard {
  final String image, title, descripcion;

  Onboard(
      {required this.image, required this.title, required this.descripcion});
}

final List<Onboard> data = [
  Onboard(
      image: 'assets/images/pavo.png',
      title: 'Solicite hornear',
      descripcion: 'Mollit in do mollit aliqua proident ut.'),
  Onboard(
      image: 'assets/images/parlante.png',
      title: 'Nosotros te notificamos',
      descripcion: 'Mollit in do mollit aliqua proident ut.'),
  Onboard(
      image: 'assets/images/cell.png',
      title: 'Nuestra app de facil uso',
      descripcion: 'Mollit in do mollit aliqua proident ut.'),
];

class CustomOnboarding extends StatelessWidget {
  const CustomOnboarding({
    Key? key,
    required this.image,
    required this.title,
    required this.descripcion,
  }) : super(key: key);
  final String image, title, descripcion;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, MyRoutes.rTYPE_ROL);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text('Omitir'),
              Icon(
                Icons.chevron_right_outlined,
                size: 30,
              ),
            ],
          ),
        ),
        const Spacer(),
        Image.asset(
          image,
          // "assets/images/pavo.png",
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          // 'Solicite hornear',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          descripcion,
          // 'Anim reprehenderit cupidatat ea laboris ad sit culpa aliqua adipisicing culpa.adasdas dsda ada das dasdas as',
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
