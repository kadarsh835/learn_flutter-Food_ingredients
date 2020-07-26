
String textFormatter(String rawText){
  List<String> tokens=rawText.split("_");
  String formattedString="";
  for(var token in tokens){
    formattedString =formattedString+ token[0].toUpperCase()+ token.substring(1) + " ";
  }
  return formattedString.substring(0, formattedString.length-1);
}