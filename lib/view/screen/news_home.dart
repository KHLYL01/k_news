import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:k_news/controller/news_controller.dart';
import 'package:k_news/core/function/toast.dart';
import 'package:k_news/model/static.dart';
import 'package:k_news/model/status_enum.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewsHome extends StatelessWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewsController controller = Get.put(NewsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Home'),
        actions: [
          Obx(
            () => Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: DropdownButton(
                value: controller.currentCountryCode.value,
                underline: Container(),
                alignment: Alignment.centerRight,
                icon: const Icon(Icons.keyboard_arrow_down),
                padding: const EdgeInsets.only(right: 16),
                items: List.generate(
                  countries.length,
                  (index) => DropdownMenuItem(
                    value: countries[index].code,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/images/${countries[index].code}.svg',
                          width: 24,
                          height: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(countries[index].name),
                      ],
                    ),
                  ),
                ),
                onChanged: (value) {
                  controller.changeCountry(value!);
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: GetBuilder<NewsController>(
        builder: (controller) {
          if (controller.statusEnum == StatusEnum.loading) {
            return const Center(
              child: SpinKitRipple(
                color: Colors.white,
              ),
            );
          }
          if (controller.statusEnum == StatusEnum.error) {
            return const Center(
              child: Text('Not Found 404'),
            );
          }
          return ListView.separated(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemCount: controller.news.length,
            itemBuilder: (context, index) {
              var item = controller.news[index];
              return GestureDetector(
                // launch website
                onTap: () async {
                  var url = Uri.parse(item.url);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    showToast(
                      msg: 'لا يمكن فتح هذا الموقع',
                    );
                  }
                },
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  width: context.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      item.urlToImage == null
                          ? Container()
                          : Image.network(item.urlToImage!),
                      ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.description ?? ''),
                      ).paddingOnly(
                        bottom: 8,
                        top: 8,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 16),
          ).paddingOnly(top: 8, right: 16, left: 16);
        },
      ),
    );
  }
}
