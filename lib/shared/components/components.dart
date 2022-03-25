//import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:newsappprox/modules/news_App/web_view/webView_screen.dart';
import 'package:newsappprox/shared/styles/colors.dart';

Widget defaultButton(
        {Color color = Colors.blue,
        double width = double.infinity,
        required String text,
        required Function function}) =>
    Container(
      color: color,
      width: width,
      child: MaterialButton(
        height: 40.0,
        onPressed: () {
          function();
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultTextFormField(
        {required String label,
        required IconData prefix,
        IconButton? suffixIcon,
        Function? onSubmit,
        Function? onTaped,
        Function? onChanged,
        bool isPassword = false,
        required TextEditingController controller,
        required TextInputType type,
        required Function validate}) =>
    TextFormField(
      onChanged: (s) {
        onChanged!(s);
      },
      controller: controller,
      keyboardType: type,
      onTap: () {
        onTaped!();
      },
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefix: Icon(
          prefix,
          color: defaultColor,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: (s) {
        validate(s);
      },
    );

Widget defaultTextButton({required Function onpress, required String text}) =>
    TextButton(
      onPressed: () {
        onpress();
      },
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: defaultColor),
      ),
    );

Widget myDividerInList() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        color: Colors.grey[300],
        height: 1.0,
        width: double.infinity,
      ),
    );
Widget buildItemArticle(article, context, {bool isSearch = false}) => InkWell(
      onTap: () {
        navigateTo(
            context,
            WebViewScreen(
              url: article['url'],
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      '${article['urlToImage'] ?? 'https://img.freepik.com/free-vector/404-error-page-found_24908-50975.jpg?w=740'}'),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

void navigateTo(context, [widget]) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color changeToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Future<Widget> bottomSheet(context) async {
  return await showModalBottomSheet(
      builder: (context) => Container(
            height: 100.0,
            width: double.infinity,
          ),
      context: context);
}
