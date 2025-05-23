import 'package:bs_score/models/player.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  String? _name;

  List<PlayerScore> scores = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
  }

  void addPlayer() {
    setState(() {
      var player = Player(_name!);
      var playerScore = PlayerScore(player);
      scores.add(playerScore);
    });

    print("New player: $_name");
  }

  void calculateScore() {
    setState(() {
      scores.sort((a, b) {
        int comp = -a.tops.compareTo(b.tops);
        if (comp == 0) {
          comp = -a.zone.compareTo(b.zone);
          if (comp == 0) {
            comp = a.tryTop.compareTo(b.tryTop);
            if (comp == 0) {
              comp = a.tryZone.compareTo(b.tryZone);
              if (comp == 0) {
                // print ("Compare last");
              }
            }
          }
        }
        return comp;
      });
    });
    for (var score in scores) {
      print(
        "score: ${score.player.name} // ${score.tops} // ${score.zone} // ${score.tryTop} // ${score.tryZone}",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 2000,
      width: 600,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 300,
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: TextButton(onPressed: addPlayer, child: Text("Add")),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: TextButton(
                    onPressed: calculateScore,
                    child: Text("Calculate"),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Tops")),
                DataColumn(label: Text("Zone")),
                DataColumn(label: Text("I. Top")),
                DataColumn(label: Text("I. Zone")),
                DataColumn(label: Text("Score")),
              ],
              rows: scores.mapIndexed((index, score) {
                score.score = index + 1;
                return DataRow(
                  cells: [
                    DataCell(Text(score.player.name)),
                    DataCell(
                      TextFormField(
                        key: Key(score.tops.toString()),
                        initialValue: '${score.tops}',
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          setState(() {
                            score.tops = int.parse(value);
                          });
                        },
                      ),
                    ),
                    DataCell(
                      TextFormField(
                        key: Key(score.zone.toString()),
                        initialValue: '${score.zone}',
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          setState(() {
                            score.zone = int.parse(value);
                          });
                        },
                      ),
                    ),
                    DataCell(
                      TextFormField(
                        key: Key(score.tryTop.toString()),
                        initialValue: '${score.tryTop}',
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          setState(() {
                            score.tryTop = int.parse(value);
                          });
                        },
                      ),
                    ),
                    DataCell(
                      TextFormField(
                        key: Key(score.tryZone.toString()),
                        initialValue: '${score.tryZone}',
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          setState(() {
                            score.tryZone = int.parse(value);
                          });
                        },
                      ),
                    ),
                    DataCell(Text('${score.score}')),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
