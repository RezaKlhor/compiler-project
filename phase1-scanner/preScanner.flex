import java.io.*;
import  java.io.IOException;
import java.util.HashMap;
import java.util.Map;

%%
%public
%class Laxer
%unicode
%standalone

%{
    StringBuffer out = new StringBuffer();
    Map<String, String> definedMap = new HashMap<String, String>();
%}

%eof{
/*
    BufferedWriter bwr = new BufferedWriter(new FileWriter(new File("out/out.txt")));
try{
    bwr.write(out.toString());

}catch (Exeption e) {
    System.out.println(e);
}
*/
System.out.println(out.toString());

%eof}

LineBreak = (\n|\r|\r\n)
NoneBreakChar = [^\n\r]
WhiteSpace = \s

//Comments
OneLineComment = ("//"{NoneBreakChar}* {LineBreak}?)
MultiLineComment="/*"~"*/"
Comment = {OneLineComment}|{MultiLineComment}

//Digits
Digit= [0-9]
HexDigit=[a-f A-F 0-9]

//Numbers
HexNumber = ("0x"|"0X") {HexDigit}+ //?
FloatNumber = {Digit}+ "." + {Digit}*
ExpoFloatNumber = {FloatNumber}"E"("-"|"+")?{Digit}+

//Literals
IntLiteral = ({Digit}+) | {HexNumber}
DoubleLiteral = {FloatNumber}|{ExpoFloatNumber} //?
BooleanLiteral = "false"|"true"
StringLiteral = \"[^(\\n|\\r)]~\" //?

//id
Identifier = [a-zA-Z][a-zA-Z0-9_]*

//definition
DefinedWord = {Identifier}
DefinedWordValue = {NoneBreakChar}+
Definition="define"{WhiteSpace}+{DefinedWord}{WhiteSpace}+{DefinedWordValue}

%%

<YYINITIAL>{
    "__func__"           {out.append("__func__");}
    "__line__"           {out.append("__line__");}
    "bool"               {out.append("bool");}
    "break"              {out.append("break");}
    "btoi"               {out.append("btoi");}
    "class"              {out.append("class");}
    "continue"           {out.append("continue");}
    "double"             {out.append("double");}
    "dtoi"               {out.append("dtoi");}
    "else"               {out.append("else");}
    "for"                {out.append("for");}
    "if"                 {out.append("if");}
    "import"             {out.append("import");}
    "int"                {out.append("int");}
    "itob"               {out.append("itob");}
    "itod"               {out.append("itod");}
    "new"                {out.append("new");}
    "NewArray"           {out.append("NewArray");}
    "null"               {out.append("null");}
    "Print"              {out.append("Print");}
    "private"            {out.append("private");}
    "public"             {out.append("public");}
    "ReadInteger"        {out.append("ReadInteger");}
    "ReadLine"           {out.append("ReadLine");}
    "return"             {out.append("return");}
    "string"             {out.append("string");}
    "this"               {out.append("this");}
    "void"               {out.append("void");}
    "while"              {out.append("while");}

    "false"              {out.append("false");}
    "true"               {out.append("true");}

	"+"					 {out.append("+");}
	"-"			    	 {out.append("-");}
	"*"					 {out.append("*");}
	"/"					 {out.append("/");}
	"%"					 {out.append("%");}
    "<"					 {out.append("<");}
    "<="				 {out.append("<=");}
    ">"					 {out.append(">");}
    ">="				 {out.append(">=");}
	"="					 {out.append("=");}
    "+="				 {out.append("+=");}
	"-="				 {out.append("-=");}
    "*="				 {out.append("*=");}
	"/="				 {out.append("/=");}
    "=="				 {out.append("==");}
    "!="				 {out.append("!=");}
	"&&"				 {out.append("&&");}
 	"||"				 {out.append("||");}
	"!"				     {out.append("!");}
	";"		    		 {out.append(";");}
	","				     {out.append(",");}
    "."				     {out.append(".");}
	"["				     {out.append("[");}
	"]"				     {out.append("]");}
	"("				     {out.append("(");}
	")"					 {out.append(")");}
	"{"					 {out.append("{");}
	"}"					 {out.append("}");}

    // definition
    {Definition} {
          String definitionLine = yytext();
          definitionLine = definitionLine.trim();
          String[] newStr = definitionLine.split("\\s+");
          String definedWord = newStr[1];

          StringBuilder stringBuilder = new StringBuilder();
          for (int i = 2; i < newStr.length; i++) {
              stringBuilder.append(newStr[i]);
              stringBuilder.append(" ");
          }
          String definedValue = stringBuilder.toString();
          definedMap.put(definedWord,definedValue);
      }

    //Literal detect action
    {BooleanLiteral}    {out.append(yytext());}
    {IntLiteral}    {out.append(yytext());}
    {DoubleLiteral}    {out.append(yytext());}
    {StringLiteral}    {out.append(yytext());}

    //Identifier detect action
    {Identifier}         {if(definedMap.containsKey(yytext())){
            out.append(definedMap.get(yytext()));
      }else{out.append(yytext());}}

    //WhiteSpace detect action
    {WhiteSpace}         {out.append(yytext());}

    //Comment detect action
    {Comment}            {out.append(yytext());}
}