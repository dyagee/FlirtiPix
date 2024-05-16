import 'package:flirtipix/services/appname.dart';
import 'package:flutter/material.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///api-call variables are imported from
  ///api_calls package

  //Map  to hold imgUrls list & other info
  //from api call after loading
  List imgUrls = [];

  final _flutterMediaDownloaderPlugin = MediaDownload();

  //randomly generated index
  late int qIndex;
  late int pageNumber;

  bool _isVisible = false;
  bool _isDownload = false;

  void _enableDownload() {
    if (!_isDownload) {
      if (mounted) {
        setState(() => _isDownload = true);
      }
    }
  }

  void _disableDownload() {
    if (_isDownload) {
      if (mounted) {
        setState(() => _isDownload = false);
      }
    }
  }

  void _show() {
    if (!_isVisible) {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    }
  }

  void _hide() {
    if (_isVisible) {
      if (mounted) {
        setState(() => _isVisible = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>?;

    imgUrls = data?['imgs'];
    qIndex = data?['index'];
    pageNumber = data?['pageNumber'];

    // ignore: avoid_print
    //print(imgUrls);

    return Scaffold(
      backgroundColor: const Color(0xFF808080),
      appBar: AppBar(
        title: appName(),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        centerTitle: true,
      ),
      body: SafeArea(
        child: imgUrls.isEmpty
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/assets/images/flp.jpg'))),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: const Color.fromARGB(164, 155, 39, 176),
                  child: Center(
                    child: Text(
                      'Nothing fetched! \n To stay Jiggy; \ntry again.... ',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        color: Colors.red,
                        fontSize: 26.0,
                        fontFamily: GoogleFonts.allertaStencil().fontFamily,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            : PageView.builder(
                itemCount: imgUrls.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 2.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Stack(
                            alignment: AlignmentDirectional.topCenter,
                            children: <Widget>[
                              DropShadowImage(
                                offset: const Offset(10.0, 10.0),
                                scale: 1.5,
                                blurRadius: 10.0,
                                borderRadius: 15.0,
                                image: Image.network(
                                  imgUrls[index]['largeImageURL'],
                                  fit: BoxFit.cover,
                                  height: (MediaQuery.of(context).size.height),
                                  width:
                                      (MediaQuery.of(context).size.width - 10),
                                ),
                              ),
                              Positioned(
                                //left: (MediaQuery.of(context).size.width / 2),
                                left: 10.0,
                                bottom: 1.0,
                                child: _isDownload
                                    ? FloatingActionButton(
                                        mini: true,
                                        tooltip: 'Download',
                                        backgroundColor:
                                            const Color(0xFF4B0082),
                                        splashColor: Colors.cyan,
                                        onPressed: () async {
                                          _flutterMediaDownloaderPlugin
                                              .downloadMedia(
                                                  context,
                                                  imgUrls[index]
                                                      ['largeImageURL']);

                                          showToast(
                                            'Downloading... check in /download folder',
                                            context: context,
                                            animation: StyledToastAnimation
                                                .slideFromBottom,
                                          );
                                        },
                                        child: const Icon(
                                          FontAwesomeIcons.download,
                                          size: 24.0,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Container(),
                              ),
                            ]),
                      ),
                    ),
                  );
                }),
      ),

      //show caretup if no bottomBar
      //show caretdown if bottomBar displayed
      floatingActionButton: _isVisible
          ? FloatingActionButton.small(
              tooltip: 'Hide Actions',
              elevation: 1.0,
              backgroundColor: Colors.white.withOpacity(0.0),
              child: const Icon(
                FontAwesomeIcons.caretDown,
                size: 28.0,
                color: Color.fromARGB(83, 255, 0, 255),
              ),
              onPressed: () {
                _hide();
              })
          : FloatingActionButton.small(
              tooltip: 'Show Actions',
              elevation: 1.0,
              backgroundColor: Colors.transparent,
              child: const Icon(
                FontAwesomeIcons.caretUp,
                size: 28.0,
                color: Color.fromARGB(83, 255, 0, 255),
              ),
              onPressed: () {
                _show();
              }),

      //dock the floatingButton to not cover app content
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,

      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: _isVisible ? 60.0 : 0.0,
        child: BottomAppBar(
          color: const Color.fromARGB(255, 34, 1, 58),
          elevation: 2.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                tooltip: 'Enable Download',
                color: const Color(0xFFFF00FF),
                splashColor: const Color(0xFF00AEEF),
                onPressed: () => showDialog<String>(
                  context: context,
                  barrierColor: const Color.fromARGB(164, 155, 39, 176),
                  builder: (BuildContext context) => AlertDialog(
                    //title: const Text('AlertDialog Title'),
                    icon: const Icon(FontAwesomeIcons.gear),
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    content: const Text(
                      'Enable Images Download?',
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      _isDownload
                          ? TextButton(
                              onPressed: () {
                                _disableDownload();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Disable'),
                            )
                          : TextButton(
                              onPressed: () {
                                _enableDownload();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Enable'),
                            ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ),
                icon: const Icon(
                  FontAwesomeIcons.wrench,
                ),
                iconSize: 18.0,
              ),
              IconButton(
                tooltip: 'Previous Page',
                color: const Color(0xFFFF00FF),
                splashColor: const Color(0xFF00AEEF),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/previous-page',
                      arguments: {
                        'imgs': imgUrls,
                        'index': qIndex,
                        'pageNumber': pageNumber,
                      });
                },
                icon: const Icon(FontAwesomeIcons.rotateLeft),
                iconSize: 18.0,
              ),
              IconButton(
                tooltip: 'Refresh',
                color: const Color(0xFFFF00FF),
                splashColor: const Color(0xFF00AEEF),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/refresh',
                  );
                },
                icon: const Icon(FontAwesomeIcons.rotate),
                iconSize: 18.0,
              ),
              IconButton(
                tooltip: 'Next Page',
                color: const Color(0xFFFF00FF),
                splashColor: const Color(0xFF00AEEF),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/next-page',
                      arguments: {
                        'imgs': imgUrls,
                        'index': qIndex,
                        'pageNumber': pageNumber,
                      });
                },
                icon: const Icon(FontAwesomeIcons.rotateRight),
                iconSize: 18.0,
              ),
              IconButton(
                tooltip: 'About App',
                color: const Color(0xFFFF00FF),
                splashColor: const Color(0xFF00AEEF),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/about-app',
                  );
                },
                icon: const Icon(FontAwesomeIcons.ellipsisVertical),
                iconSize: 18.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//class handle bottomBar display
// class _BottomBarClass extends StatelessWidget {
//   const _BottomBarClass({required this.isVisible});

//   final bool isVisible;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 250),
//       height: isVisible ? 60.0 : 0.0,
//       child: BottomAppBar(
//         color: const Color.fromARGB(255, 34, 1, 58),
//         elevation: 2.5,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             IconButton(
//               tooltip: 'Previous Page',
//               color: const Color(0xFFFF00FF),
//               splashColor: const Color(0xFF00AEEF),
//               onPressed: () {},
//               icon: const Icon(FontAwesomeIcons.rotateLeft),
//               iconSize: 18.0,
//             ),
//             IconButton(
//               tooltip: 'Refresh',
//               color: const Color(0xFFFF00FF),
//               splashColor: const Color(0xFF00AEEF),
//               onPressed: () {},
//               icon: const Icon(FontAwesomeIcons.rotate),
//               iconSize: 18.0,
//             ),
//             IconButton(
//               tooltip: 'Next Page',
//               color: const Color(0xFFFF00FF),
//               splashColor: const Color(0xFF00AEEF),
//               onPressed: () {},
//               icon: const Icon(FontAwesomeIcons.rotateRight),
//               iconSize: 18.0,
//             ),
//             IconButton(
//               tooltip: 'About',
//               color: const Color(0xFFFF00FF),
//               splashColor: const Color(0xFF00AEEF),
//               onPressed: () {},
//               icon: const Icon(FontAwesomeIcons.ellipsisVertical),
//               iconSize: 18.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
