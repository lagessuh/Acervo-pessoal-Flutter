import 'package:acervo/helpers/responsive.dart';
//import 'package:acervo/pages/commodity/commodity_list_search_page.dart';
import 'package:flutter/material.dart';

class MyCardAdm extends StatelessWidget {
  const MyCardAdm(
      {super.key,
      required this.height,
      this.onTap,
      required this.imageCard,
      required this.nameCard});

  final double height;
  final VoidCallback? onTap;
  final String imageCard, nameCard;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: Responsive.isExtraLarge(context)
            ? height * .25
            : Responsive.isDesktop(context)
                ? height * .36
                : Responsive.isLaptop(context)
                    ? height * .35
                    : Responsive.isTablet(context)
                        ? height * .30
                        : height * .15,
        width: MediaQuery.of(context).size.width * .60,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  imageCard,
                  height: Responsive.isExtraLarge(context)
                      ? height * .15
                      : Responsive.isDesktop(context)
                          ? 140
                          : Responsive.isLaptop(context)
                              ? 130
                              : Responsive.isTablet(context)
                                  ? 100
                                  : 80,
                  width: Responsive.isExtraLarge(context)
                      ? height * .15
                      : Responsive.isDesktop(context)
                          ? 140
                          : Responsive.isLaptop(context)
                              ? 130
                              : Responsive.isTablet(context)
                                  ? 100
                                  : 80,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                nameCard,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Responsive.isDesktop(context)
                      ? 20
                      : Responsive.isTablet(context)
                          ? 18
                          : 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
