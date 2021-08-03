import 'dart:developer';
import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:space_api/blocs/blocs.dart';
import 'package:space_api/custom_observer.dart';
import 'package:space_api/utils/fullscreen_image.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'utils/utils.dart';
import 'package:flutter/services.dart';

void main() {
  Bloc.observer = CustomObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return BlocProvider<SpaceXBloc>(
      create: (context) => SpaceXBloc()..add(FetchLatestMission()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          body: BlocBuilder<SpaceXBloc, SpaceXState>(builder: (context, state) {
            SizeConfig().init(context);
            if (state is InitialState) {
              return new FlareActor("assets/space.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "Untitled");
            }
            if (state is Fetched) {
              return infoContainer(context);
            } else {
              return Text("An error occured.");
            }
          }),
        ),
      ),
    );
  }

  Widget infoContainer(BuildContext context) {
    return BlocBuilder<SpaceXBloc, SpaceXState>(
      builder: (context, state) {
        if (state is Fetched) {
          List<String> images = state.info.images;
          log(images.toString());
          return Center(
            child: Container(
              color: Colors.white24,
              width: SizeConfig.widthMultiplier * 100,
              height: SizeConfig.heightMultiplier * 80,
              child: Stack(
                children: [
                  Center(
                    child: new Container(
                      height: 300,
                      width: 300,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new NetworkImage(state.info.patchUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: new BackdropFilter(
                        filter:
                            new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: new Container(
                          decoration: new BoxDecoration(
                              color: Colors.white.withOpacity(0.0)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Scrollbar(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DefaultTextStyle(
                                    style: CustomTextConfig(context).display1,
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        TyperAnimatedText(state.info.name,
                                            speed: const Duration(milliseconds: 150)),
                                      ],
                                      isRepeatingAnimation: false,
                                    )),
                                IconButton(
                                  tooltip: "View on reddit",
                                  iconSize: 45,
                                  color: Colors.black54,
                                  icon: Icon(FontAwesomeIcons.reddit),
                                  onPressed: () async {
                                    await canLaunch(state.info.redditUrl)
                                        ? await launch(state.info.redditUrl)
                                        : throw 'Could not launch ${state.info.redditUrl}';
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3.0,
                            ),

                            RichText(
                                text: TextSpan(
                                    style: CustomTextConfig(context).display3,
                                    children: [
                                  TextSpan(text: "Firing Time: "),
                                  TextSpan(
                                      text:
                                          "${state.info.firingTime.split("T")[0]}",
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold))
                                ])),
                            //Text("Firing Time: ${state.info.firingTime.split("T")[0]}", style: CustomTextConfig(context).display3),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 1.5,
                            ),
                            Text(state.info.details,
                                textAlign: TextAlign.justify,
                                style: CustomTextConfig(context).display3),
                            StaggeredGridView.countBuilder(
                                shrinkWrap: true,
                                primary: false,
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 4,
                                itemCount: images.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: FullScreenWidget(
                                        disposeLevel: DisposeLevel.High,
                                        child: Hero(
                                          tag: images[index],
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            child: FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image: images[index],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                                staggeredTileBuilder: (index) {
                                  return StaggeredTile.count(
                                      1, index.isEven ? 1.1 : 1.4);
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          throw Exception("Err");
        }
      },
    );
  }
}