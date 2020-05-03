import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_english/core/models/vocabulary.dart';
import 'package:learn_english/core/services/database_service.dart';
import 'package:learn_english/ui/modules/route_name.dart';
import 'package:learn_english/ui/pages/loading_page.dart';
import 'package:learn_english/ui/state/account_user.dart';
import 'package:provider/provider.dart';
import 'package:learn_english/ui/modules/audio_player.dart';

class LearnedWords extends StatelessWidget {
  Database database = Database();
  List<String> lessonList;
  AudioPlayer playAudio = AudioPlayer();

  Future<List<Vocabulary>> getVocabByLesson(List<String> lessonId) async {
    var list = await database.getVocabByLesson(lessonId);

    return list;
  }

  @override
  Widget build(BuildContext context) {
    AccountUser accountUser = Provider.of<AccountUser>(context);
    if (accountUser.user == null) return LoadingPage();
    if (accountUser.user.learningState == null)
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Learned Words',
            style: GoogleFonts.handlee(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: Colors.green[300],
        ),
        body: Center(child: Text('No data')),
      );
    lessonList = accountUser.user.learningState.keys.toList();
    return (lessonList == null)
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Learned Words',
                style: GoogleFonts.handlee(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ),
              backgroundColor: Colors.green[300],
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: FutureBuilder(
                future: getVocabByLesson(lessonList),
                builder: (context, AsyncSnapshot<List<Vocabulary>> value) {
                  if (value.data == null) return LoadingPage();

                  return ListView.builder(
                      itemCount: value.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            value.data[index].vocab,
                            style: TextStyle(fontSize: 22),
                          ),
                          subtitle: Text(
                            value.data[index].mean,
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: IconButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                playAudio.playCustomAudioFile(
                                    value.data[index].audioFile);
                              },
                              icon: Icon(
                                Icons.volume_up,
                                size: 20,
                              )),
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.detailWord,
                                arguments: [value.data, index]);
                          },
                        );
                      });
                },
              ),
            ),
          );
  }
}