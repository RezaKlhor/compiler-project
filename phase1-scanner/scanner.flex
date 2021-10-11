%%
%public
%class Laxer
%unicode
%standalone

%{
    StringBuffer out = new StringBuffer();
    Map<String, String> defineMap = new HashMap<String, String>();
%}

/* comments */
InputCharacter = [^\r\n]
Comment = {TraditionalComment} | {EndOfLineComment}
TraditionalComment= "/*"~"*/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?

Identifier = [:jletter:][:jletterdigit:]*

LineTerminator = \r|\n|\r\n

WhiteSpace = {LineTerminator} | [ \t\f]

DecInteger = [0-9]*

HexNumber = "0"[xX][0-9a-fA-F]*

// to check
FloatNumber = \d+\.\d*([eE]([+-])?\d+)?

string = \"[^(\\n|\\r)]~\"

%%
<YYINITIAL>{
    "__func__"           {out.append("__func__\n");}
    "__line__"           {out.append("__line__\n");}
    "bool"               {out.append("bool\n");}
    "break"              {out.append("break\n");}
    "btoi"               {out.append("btoi\n");}
    "class"              {out.append("class\n");}
    "continue"           {out.append("continue\n");}
    "define"             {out.append("define\n");}
    "double"             {out.append("double\n");}
    "dtoi"               {out.append("dtoi\n");}
    "else"               {out.append("else\n");}
    "for"                {out.append("for\n");}
    "if"                 {out.append("if\n");}
    "import"             {out.append("import\n");}
    "int"                {out.append("int\n");}
    "itob"               {out.append("itob\n");}
    "itod"               {out.append("itod\n");}
    "new"                {out.append("new\n");}
    "NewArray"           {out.append("NewArray\n");}
    "null"               {out.append("null\n");}
    "Print"              {out.append("Print\n");}
    "private"            {out.append("private\n");}
    "public"             {out.append("public\n");}
    "ReadInteger"        {out.append("ReadInteger\n");}
    "ReadLine"           {out.append("ReadLine\n");}
    "return"             {out.append("return\n");}
    "string"             {out.append("string\n");}
    "this"               {out.append("this\n");}
    "void"               {out.append("void\n");}
    "while"              {out.append("while\n");}

    "define"             {defineMap.put("","");}

//    "‫‪dtoi‬‬"               {out.append("‫‪dtoi‬‬\n");}
//    "‫‪itod‬‬"               {out.append("‫‪itod‬‬\n");}
//    "‫‪btoi‬‬"               {out.append("‫‪btoi‬‬\n");}
//    "‫‪itob‬‬"               {out.append("‫‪itob‬‬\n");}
//    "‫‪private‬‬"            {out.append("‫‪private\n");}
//    "‫‪protected‬‬"          {out.append("‫‪protected‬‬\n");}
//    "‫‪public‬‬"             {out.append("‫‪public‬‬\n");}

    "false"              {out.append("T_BOOLEANLITERAL false\n");}
    "true"               {out.append("T_BOOLEANLITERAL true\n");}

	"+"					 {out.append("+\n");}
	"-"			    	 {out.append("-\n");}
	"*"					 {out.append("*\n");}
	"/"					 {out.append("/\n");}
	"%"					 {out.append("%\n");}
    "<"					 {out.append("<\n");}
    "<="				 {out.append("<=\n");}
    ">"					 {out.append(">\n");}
    ">="				 {out.append(">=\n");}
	"="					 {out.append("=\n");}
    "+="				 {out.append("=\n");}
	"-="				 {out.append("=\n");}
    "*="				 {out.append("=\n");}
	"/="				 {out.append("=\n");}
    "=="				 {out.append("==\n");}
    "!="				 {out.append("!=\n");}
	"&&"				 {out.append("&&\n");}
 	"||"				 {out.append("||\n");}
	"!"				     {out.append("!\n");}
	";"		    		 {out.append(";\n");}
	","				     {out.append(",\n");}
    "."				     {out.append(".\n");}
	"["				     {out.append("[\n");}
	"]"				     {out.append("]\n");}
	"("				     {out.append("(\n");}
	")"					 {out.append(")\n");}
	"{"					 {out.append("{\n");}
	"}"					 {out.append("}\n");}


    {Identifier}         { out.append("T_ID " + yytext() +"\n"); }
    {WhiteSpace}         {/*ignore*/}
    {DecInteger}         { out.append("T_INTLITERAL " + yytext() +"\n"); }
    {HexNumber}          { out.append("T_INTLITERAL " + yytext() +"\n"); }
    {FloatNumber}        { out.append("T_DOUBLELITERAL "+ yytext() +"\n");}
    {string}             { out.append("T_STRINGLITERAL " + yytext() +"\n");}
    {Comment}            {/*ignore*/}
}