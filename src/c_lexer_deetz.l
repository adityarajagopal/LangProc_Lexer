%option noyywrap

%{
#include <stdio.h>
#include <iostream>
#include <string>
enum tokType{ hash_func,src_info,loopkey,returnkey,typedefkey,loopctrlkey,selectkey,typekey,defkey,underkey,floats,octs,hexs,digit,chars,id,oper,semi_colon,inc,dec,compound_op,relation_op,assign_op,logic_op,ternary_op,comma_op,bitwise_op,sizeof_op,arith_op,brackets,str_lit,newline,tab,done_file };

int constant;
int lines = 1;
std::string constfloat;
std::string consthex;
std::string constchar;
std::string opName;
std::string strVal;
std::string IDVal;
std::string srcFile;
std::string srcFileIn;
int srcLine = 0;

%}

SRC_FILE_1	#[ ][0-9]+[ ]

SRC_FILE_2	["]([^\\"]|\\.)*["] 

SRC_FILE_3	([ ][1])?([ ][2])?([ ][3])?([ ][4])?$

HASH_FUNC	#.*$

UNDER_KWD	"__"

LOOP_KWD	for|while|do

RETURN		return

TYPEDEF		typedef

SIZEOF		sizeof

LOOP_CTRL	break|continue|goto

SELECT_KWD	if|else|switch|case|default

TYPE_KWD	char|double|int|void|float|enum|extern|struct|volatile|union

DEF_KWD		auto|const|unsigned|long|short|signed|register|static

FLOAT		([+-]?([0-9]+[.]?[0-9]*|[0-9]*[.]?[0-9]+)([eE][+-]?[0-9]+)?([fFlL])?)

OCT			0[0-7]*(((u|U)(l|L|ll|LL)?)|((l|L|ll|LL)(u|U)?))?

HEX			0[x|X]([a-fA-F]|[0-9])+(((u|U)(l|L|ll|LL)?)|((l|L|ll|LL)(u|U)?))?

DIGIT		[+-]?[0-9]+(((u|U)(l|L|ll|LL)?)|((l|L|ll|LL)(u|U)?))?

ID			[_a-zA-Z][_a-zA-Z0-9]*

OPERATOR	"->"|"."|"..."

SEMI_COLON	";"

INC			"++"

DEC			"--"

COMPOUND_OP	"+="|"-="|"*="|"%="|"/="|">>="|"<<="|"&="|"^="|"|="

RELATION_OP	"=="|"!="|">="|"<="|"<"|">"

ASSIGN_OP	"="

LOGIC_OP	"!"|"&&"|"||"

TERNARY_OP	"?"|":"

COMMA_OP	","

BITWISE_OP	"&"|"|"|"^"|"~"|"<<"|">>"

ARITH_OP	"+"|"-"|"*"|"/"|"%"

BRACKETS	"("|")"|"["|"]"|"{"|"}"

STR_LIT		["]([^\\"]|\\.)*["]

CHAR		[']([^\\']|\\.)[']

NEWLINE		[\n]

TAB			[\t]*

SPACE		" "*

%%

{SRC_FILE_1}{SRC_FILE_2}{SRC_FILE_3}		{std::string tmpSrcFileIn(yytext); srcFileIn = tmpSrcFileIn; srcLine = (atoi(&yytext[2]) - 1); return src_info; }

{HASH_FUNC}			{  return hash_func; }

{UNDER_KWD}			{ strVal = yytext; return underkey; }
{LOOP_KWD}			{ strVal = yytext; return loopkey; }
{RETURN}			{ strVal = yytext; return returnkey; }
{TYPEDEF}			{ strVal = yytext; return typedefkey; }
{SIZEOF}			{ opName = yytext; return sizeof_op; }
{LOOP_CTRL}			{ strVal = yytext; return loopctrlkey; }
{SELECT_KWD}		{ strVal = yytext; return selectkey; }
{TYPE_KWD}			{ strVal = yytext; return typekey; }
{DEF_KWD}			{ strVal = yytext; return defkey; }

{OCT}				{ consthex = yytext; return octs; }
{HEX}				{ consthex = yytext; return hexs; }		
{DIGIT}				{ constant = atoi(yytext); return digit; }
{FLOAT}				{ constfloat = yytext; return floats; }
{CHAR}				{ constchar = yytext; return chars; }

{ID}				{ IDVal = yytext; return id; }

{OPERATOR}			{ opName = yytext; return oper; }
{SEMI_COLON}		{ opName = yytext; return semi_colon; }
{INC}				{ opName = yytext; return inc; }
{DEC}				{ opName = yytext; return dec; }
{COMPOUND_OP}		{ opName = yytext; return compound_op; }
{RELATION_OP}		{ opName = yytext; return relation_op; }
{ASSIGN_OP}			{ opName = yytext; return assign_op; }
{LOGIC_OP}			{ opName = yytext; return logic_op; }
{TERNARY_OP}		{ opName = yytext; return ternary_op; }
{COMMA_OP}			{ opName = yytext; return comma_op; }
{BITWISE_OP}		{ opName = yytext; return bitwise_op; }
{ARITH_OP}			{ opName = yytext; return arith_op; }
{BRACKETS}			{ opName = yytext; return brackets; }

{STR_LIT}			{ strVal = yytext; return str_lit; }

{NEWLINE}			{ return newline; }
{TAB}				{ return tab; }
{SPACE}				{ return tab; }
<<EOF>>				{ return done_file; }

%%

int main()
{
	std::size_t quotestart = 0;
	std::size_t quoteend = 0;
	std::size_t quotediff = 0;
	int x = 1;
    while(x){
		switch(yylex()){
		case src_info:		quotestart = srcFileIn.find('"'); quoteend = srcFileIn.find('"', quotestart + 1); quotediff = quoteend - quotestart; srcFile = srcFileIn.substr(quotestart, quotediff+1); break;
		case hash_func:		break;
		case loopkey:		std::cout << strVal << " Keyword " << "T_" << strVal << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case returnkey:		std::cout << strVal << " Keyword " << "T_" << strVal << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case typedefkey:	std::cout << strVal << " Keyword " << "T_" << strVal << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case loopctrlkey:	std::cout << strVal << " Keyword " << "T_" << strVal << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case selectkey:		std::cout << strVal << " Keyword " << "T_" << strVal << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case typekey:		std::cout << strVal << " Keyword " << "T_" << strVal << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case defkey:		std::cout << strVal << " Keyword " << "T_" << strVal << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case underkey:		std::cout << strVal << " Keyword " << "T_" << strVal << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case floats:		std::cout << constfloat << " Constant " << "T_float " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case hexs:			std::cout << consthex << " Constant " << " T_hex " << lines << "  " << srcFile << "  " << srcLine << std::endl; break;
		case octs:			std::cout << consthex << " Constant " << "T_oct  " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case digit:			std::cout << constant << " Constant " << "T_int " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case chars:			std::cout << constchar << " Constant " << "T_char " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case id:			std::cout << IDVal << " Identifier " << "T_ID " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case sizeof_op:		std::cout << opName << " Operator " << "T_" << opName  << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case oper:			std::cout << opName << " Operator " << "T_" << opName << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case semi_colon:	std::cout << opName << " Operator " << "T_" << opName << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case inc:			std::cout << opName << " Operator " << "T_" << opName << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case dec:			std::cout << opName << " Operator " << "T_" << opName << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case compound_op:	std::cout << opName << " Operator " << "T_" << opName << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case relation_op:	std::cout << opName << " Operator " << "T_" << opName << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case assign_op:		std::cout << opName << " Operator " << "T_" << opName << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case logic_op:		std::cout << opName << " Operator " << "T_" << opName << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case ternary_op:	std::cout << opName << " Operator " << "T_" << opName << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case comma_op:		std::cout << opName << " Operator " << "T_" << opName << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case bitwise_op:	std::cout << opName << " Operator " << "T_" << opName << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case arith_op:		std::cout << opName << " Operator " << "T_" << opName << " " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case brackets:		std::cout << opName << " Operator " << "T_" << opName << " " << lines << " " << srcFile << " " << srcLine << std::endl; break;
		case str_lit:		std::cout << strVal << " StringLiteral "<< "T_string " << lines << " " << srcFile << "  " << srcLine << std::endl; break;
		case newline:		lines++; srcLine++; break;
		case tab:			break;
		case done_file:		x = 0; break;
		default:			std::cout << "Invalid" << std::endl; break;
		}
		if (x != 0)	x++;
	}
	
    return 0;
}

