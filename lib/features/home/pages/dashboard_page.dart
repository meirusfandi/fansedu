import 'package:auto_route/annotations.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/core/widgets/utils.dart';
import 'package:fansedu/features/home/widgets/articles_widget.dart';
import 'package:fansedu/features/home/widgets/courses_widget.dart';
import 'package:fansedu/features/home/widgets/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Loadable(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Welcome, ",
                style: TextStyle(
                    fontFamily: "PlusJakartaSans",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorWidget.blackColor
                )
              ),
              TextSpan(
                text: "Mei",
                  style: TextStyle(
                      fontFamily: "PlusJakartaSans",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorWidget.primaryColor
                  )
              )
            ]
          ),
        ).leftPadded(8),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(getSourceBySvg('ic_notification'), width: 24, height: 24),
          ).rightPadded(24)
        ],
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: LeftAlignedColumn(
            children: [
              // progress section
              TextWidget.jakartaSansBold("Your Progress", size: 18, color: ColorWidget.primaryColor).horizontalPadded(24),
              ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ProgressWidget().horizontalPadded(24).verticalPadded(8);
                }
              ),

              // categories section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget.jakartaSansBold("Categories", size: 18, color: ColorWidget.primaryColor),
                  GestureDetector(
                    onTap: () {},
                    child: TextWidget.jakartaSansRegular("See All", size: 10, color: ColorWidget.iconColor),
                  )
                ]
              ).horizontalPadded(24).topPadded(),
              SizedBox(
                height: 42,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: ColorWidget.secondaryColor)
                      ),
                      child: TextWidget.jakartaSansSemiBold("Category ${index+1}", size: 12, color: ColorWidget.primaryColor).padded(12),
                    ).leftPadded((index == 0) ? 24: 16).rightPadded((index == 4) ? 24 : 0);
                  }
                ),
              ).verticalPadded(8),

              // courses active section
              TextWidget.jakartaSansBold("Active Courses", size: 18, color: ColorWidget.primaryColor).horizontalPadded(24).verticalPadded(),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 2/3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CoursesWidget(
                      images: "img_course_1",
                      title: "Courses 1",
                      categories: 'Categories 1',
                      rating: "4.7"
                  ),
                  CoursesWidget(
                      images: "img_course_2",
                      title: "Courses 2",
                      categories: 'Categories 2',
                      rating: "4.9"
                  ),
                  CoursesWidget(
                      images: "img_course_3",
                      title: "Courses 3",
                      categories: 'Categories 3',
                      rating: "4.2"
                  ),
                  CoursesWidget(
                      images: "img_course_4",
                      title: "Courses 4",
                      categories: 'Categories 4',
                      rating: "4.0"
                  ),
                ],
              ).horizontalPadded(24),

              // article section
              TextWidget.jakartaSansBold("Articles", size: 18, color: ColorWidget.primaryColor).horizontalPadded(24).topPadded(),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ArticlesWidget(
                    images: "img_articles_${index+1}",
                    title: "Title ${index+1}",
                    desc: "Desc ${index+1}"
                  ).verticalPadded(8);
                }
              ).horizontalPadded(24)
            ],
          ),
        )
      ),
    );
  }
}
