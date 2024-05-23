import 'dart:collection';

import 'package:app_apk/objects/player.dart';

import '../objects/team.dart';

class dataList {
  static HashMap playerMap = HashMap<teamWidget, List<playerWidget>>();

  bool isLoaded = false;

  List getListDynamic() {
    return playerMap.keys.toList();
  }

  void addDynamic(teamWidget x) {
    playerMap[x] = <playerWidget>[];
  }

  void removeDynamic(teamWidget x) {
    playerMap.remove(x);
  }

  void addPlayer(teamWidget x, playerWidget name) {
    List<playerWidget> test = playerMap[x];
    test.add(name);
  }

  void removePlayer(teamWidget x, playerWidget name) {
    List<playerWidget> test = playerMap[x];
    test.remove(name);
  }

  List getPlayers(teamWidget x) {
    return playerMap[x];
  }

  List getAllPlayers() {
    List<playerWidget> playerList = [];
    for (teamWidget x in getListDynamic()) {
      playerList.addAll(playerMap[x]);
    }
    return playerList;
  }

  List? getPlayersThroughName(String name) {
    for (teamWidget x in getListDynamic()) {
      if (x.getName() == name) {
        return playerMap[x];
      }
    }
    return null;
  }

  void clearMap() {
    playerMap.clear();
  }
}
