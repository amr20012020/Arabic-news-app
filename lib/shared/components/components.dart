import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:news_app/modules/webview/Web_View_Screen.dart';


Widget NewsItem(item, context) =>InkWell(
  onTap: () {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewScreen(item['url'])));
  },
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [

        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: NetworkImage(item['urlToImage'] ??
                    'https://tse2.mm.bing.net/th?id=OIP.8WSe_c3zS8KGOnvSkg1d-wHaE7&pid=Api&P=0&w=305&h=204'),
                fit: BoxFit.cover,
              )
          ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    child: Text(item['title'], style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,),
                  ),
                ),
                Container(
                  child: Text(item['publishedAt'],
                    style: TextStyle(color: Colors.grey),),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);


Widget Builder_item(list) =>
    ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) =>
          ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => NewsItem(list[index], context),
              separatorBuilder: (context, index) =>
                  SizedBox(
                    height: 9,
                  ),
              itemCount: list.length),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );