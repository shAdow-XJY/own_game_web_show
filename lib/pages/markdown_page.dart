import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

class MarkDownPage extends StatefulWidget {
  final String title;
  const MarkDownPage(
      {Key? key,
        required this.title
      }) : super(key: key);

  @override
  State<MarkDownPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MarkDownPage> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const ImageIcon(AssetImage('assets/images/GitHub.png')),
                onPressed: () {
                  launchUrl(Uri.parse('https://github.com/shAdow-XJY/own_game_web_show'));
                },
              ),
            ],
          )
        ],
      ),
      body: Container(
          margin: const EdgeInsets.all(0.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Theme.of(context).primaryColor),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topCenter,
                tileMode: TileMode.mirror,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.5),
                  Theme.of(context).colorScheme.surface,
                ]
              ),
            boxShadow: const [BoxShadow()],
          ),
          child: FutureBuilder<String>(
              future: rootBundle.loadString('assets/markdown/${widget.title}.md'),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        MarkdownBody(
                          data: snapshot.data!,
                          selectable: true,
                          softLineBreak:true,
                          extensionSet:md.ExtensionSet(
                            md.ExtensionSet.gitHubWeb.blockSyntaxes,
                            md.ExtensionSet.gitHubWeb.inlineSyntaxes,
                          ),
                          onTapLink: (String linkPath, String? href, String title) {
                            launchUrl(Uri.parse(href!));
                          },
                          styleSheet: MarkdownStyleSheet(
                            h1Padding: const EdgeInsets.symmetric(vertical: 4.0),
                            h2Padding: const EdgeInsets.symmetric(vertical: 3.0),
                            h3Padding: const EdgeInsets.symmetric(vertical: 2.0),
                            h4Padding: const EdgeInsets.symmetric(vertical: 1.5),
                            h5Padding: const EdgeInsets.symmetric(vertical: 1.0),
                            h6Padding: const EdgeInsets.symmetric(vertical: 0.5),
                            h1: const TextStyle(fontSize: 45, fontWeight: FontWeight.w900,),
                            h2: const TextStyle(fontSize: 35, fontWeight: FontWeight.w700,),
                            h3: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500,),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                else{
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.purple,
                    ),
                  );
                }
              }
          ),
      ),
    );
  }
}