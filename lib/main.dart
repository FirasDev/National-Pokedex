
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:national_pokedex/PocketMonsters.dart';
import 'package:national_pokedex/pokemondetail.dart';
import 'package:random_color/random_color.dart';
import 'widgets/fab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main()=> runApp(MaterialApp(
  title: "National Pokedex",
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  //chinese english japanese
  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PocketMonsters pocketMonsters;
  Animation<double> _animation;
  AnimationController _controller;
  

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _controller);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();

    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pocketMonsters = PocketMonsters.fromJson(decodedJson);
    print(pocketMonsters.toJson());
    setState(() {});

  }

  guessColor(type){
    RandomColor _randomColor = RandomColor();

    switch (type) {
      case "Grass": 
      return new Color(0xff2cdab1);
        break;
      case "Normal": 
      return Colors.grey;
        break;
      case "Fighting": 
      return _randomColor.randomColor(colorHue: ColorHue.red,colorSaturation: ColorSaturation.highSaturation);
        break;
      case "Flying": 
      return _randomColor.randomColor(colorHue: ColorHue.blue,colorBrightness: ColorBrightness.veryLight);
        break;
      case "Poison": 
      return _randomColor.randomColor(colorHue: ColorHue.purple,colorBrightness: ColorBrightness.dark);
        break;
      case "Ground": 
      return Colors.brown;
        break;
      case "Rock": 
      return _randomColor.randomColor(colorHue: ColorHue.purple,colorSaturation: ColorSaturation.highSaturation,colorBrightness: ColorBrightness.veryLight);
        break;
      case "Bug": 
      return Colors.lightGreen;
        break;
      case "Ghost": 
      return Colors.deepPurple;
        break;
      case "Steel": 
      return Colors.blueGrey;
        break;
      case "Fire": 
      return new Color(0xfff7786b);
        break;
      case "Water": 
      return new Color(0xff58abf6);
        break;
      case "Electric": 
      return new Color(0xffffce4b);
        break;
      case "Psychic": 
      return Colors.pink;
        break;
      case "Ice": 
      return _randomColor.randomColor(colorHue: ColorHue.blue,colorSaturation: ColorSaturation.highSaturation,colorBrightness: ColorBrightness.veryLight);
        break;
      case "Dragon": 
      return _randomColor.randomColor(colorHue: ColorHue.blue,colorSaturation: ColorSaturation.lowSaturation,colorBrightness: ColorBrightness.dark);
        break;
      case "Fairy": 
      return _randomColor.randomColor(colorHue: ColorHue.pink,colorSaturation: ColorSaturation.highSaturation,colorBrightness: ColorBrightness.veryLight);
        break;
      case "Dark": 
      return Colors.white;
        break;
      default: Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: new Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text("National Pokédex",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: new Color(0xfff5f5f5),
      ),
      body:
      Stack(
        children: <Widget>[
          pocketMonsters == null?Center(child: CircularProgressIndicator(),) :
      GridView.count(crossAxisCount: 2,
      children: pocketMonsters.pokemon
      .map((pokemon)=>Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PokemonDetail(
              pokemon: pokemon,
              bgcolor: guessColor(pokemon.type.first),
              
            )));
          },
          child: Hero(
            tag: pokemon.img,
            child: Card(
              color: guessColor(pokemon.type.first),
              elevation: 3.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(pokemon.img))
                    ),
                  ),
                  Text(pokemon.name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
                   color: Colors.white,
      shadows: [
        Shadow( // bottomLeft
          offset: Offset(-1.5, -1.5),
          color: Colors.black
        ),
        Shadow( // bottomRight
          offset: Offset(1.5, -1.5),
          color: Colors.black
        ),
        Shadow( // topRight
          offset: Offset(1.5, 1.5),
          color: Colors.black
        ),
        Shadow( // topLeft
          offset: Offset(-1.5, 1.5),
          color: Colors.black
        ),
      ]
      )
      )
                ],
              ),
            ),
          ),
        ),
      )).toList(),
      ),
      AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return IgnorePointer(
                ignoring: _animation.value == 0,
                child: InkWell(
                  onTap: () {
                    _controller.reverse();
                  },
                  child: Container(
                    color: Colors.black.withOpacity(_animation.value * 0.5),
                  ),
                ),
              );
            },
          ),
        ],
      ),

      floatingActionButton: ExpandedAnimationFab(
        items: [
          FabItem(
            "A - Z",
            FontAwesomeIcons.sortAlphaUp,
            onPress: () {
              _controller.reverse();
            },
          ),
          FabItem(
            "Type",
            FontAwesomeIcons.fire,
            onPress: () {
              _controller.reverse();
            },
          ),
          FabItem(
            "Gen",
            Icons.filter_vintage,
            onPress: () {
              _controller.reverse();
              //_showGenerationModal();
            },
          ),
          FabItem(
            "Search",
            Icons.search,
            onPress: () {
              _controller.reverse();
              //_showSearchModal();
            },
          ),
        ],
        animation: _animation,
        onPress: () {
          if (_controller.isCompleted) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
      ),
    );
  }
}