import 'package:flutter/material.dart';
import 'package:national_pokedex/PocketMonsters.dart';
import 'package:random_color/random_color.dart';

class PokemonDetail extends StatelessWidget {

  final Pokemon pokemon;
  final Color bgcolor;

    guessColor(type){
    RandomColor _randomColor = RandomColor();

    switch (type) {
      case "Grass": 
      return Colors.green;
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
      return Colors.red;
        break;
      case "Water": 
      return Colors.blue;
        break;
      case "Electric": 
      return Colors.yellow;
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

  PokemonDetail({this.pokemon,this.bgcolor});
  
  bodyWidget(BuildContext context)=>Stack(
    
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height/1.5,
        width: MediaQuery.of(context).size.width-20,
        left: 10.0,
        top: MediaQuery.of(context).size.height*0.1,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              Text(pokemon.name,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
              Text("Height : ${pokemon.height}"),
              Text("Weight : ${pokemon.weight}"),
              Text("Types :",style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.type.map((t)=> 
                FilterChip(
                  backgroundColor: guessColor(t),
                  label: Text(t,style: TextStyle(color: Colors.white)),onSelected: (b){}
                  ))
                .toList(),
              ),
              Text("Weakness :",style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.weaknesses.map((t)=> 
                FilterChip(
                  backgroundColor: guessColor(t),
                  label: Text(t,style: TextStyle(color: Colors.white)),onSelected: (b){}
                  ))
                .toList(),
              ),
                  Text("Next Evolution :",style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: pokemon.nextEvolution.map((t)=> 
                FilterChip(
                  backgroundColor: Colors.amber,
                  label: Text(t.name),onSelected: (b){}))
                .toList(),
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(
          tag: pokemon.img,
          child: Container(
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(pokemon.img))
            ),
          ),
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: bgcolor,
        centerTitle: true,
      ),
      body: bodyWidget(context) ,
    );
  }
}