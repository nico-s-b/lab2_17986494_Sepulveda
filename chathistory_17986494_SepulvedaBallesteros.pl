%ChatHistory = null|list
%Representación: Lista: [[Time,ChatbotCode,FlowCode,Message]|ChatH]
%Time (string)
%ChatbotCode (int)
%FlowCode (int)
%Message (string)

%Predicado verificador de un elemento de chatHistory
% chatVerifier(ChatHistory)
%Dominio: ChatHistory (list)
% Meta primaria: chatVerifier
% Metas secundarias: string/1 , integer/1 , chatVerifier/1
chatVerifier([]).
chatVerifier([[Time,Cblink,Flink,Msg]|Resto]):-
    string(Time),
    string(Msg),
    integer(Cblink),
    integer(Flink),
    chatVerifier(Resto).

% Predicado que arma el string correspondiente a un mensaje o elemento de chat
% chatToStr(User,Time,Message,ChatbotName,FlowMens,Options,FormatedStr)
%Dominio: User (string) X Time (string) X ChatbotName (string) X
%FlowMens (string) X Options (list of options) X FormatedStr (string)
% Meta primaria: chatToStr/7
% Metas secundarias: string_concat/3 , optionStringList/3
chatToStr(User,Time,Msg,CbotName,FlowMens,Oplist,StrRes):-
    string_concat(Time,": ",Str1),string_concat(Str1,User,Str2),string_concat(Str2,": ",Str3),string_concat(Str3,Msg,Str4),string_concat(Str4,"\n",Str5),
    string_concat(Str5,Time,Str6),string_concat(Str6,": ",Str7),string_concat(Str7,CbotName,Str8),string_concat(Str8,": ",Str9),string_concat(Str9,FlowMens,Str10),
    string_concat(Str10,"\n",Str11),
    optionStringList(Oplist,"",OptionString),
    string_concat(Str11,OptionString,StrRes).

% Predicado que arma el string en forma de listado de opciones
% asociadas a un flujo, a partir de una lista de opciones
% optionStringList(Options, StrAcc, StrRes)
%Dominio: Options (list of options) X StrAcc (string) X StrRes (string)
% Meta primaria: optionStringList/3
% Metas secundarias: optionGetElements/6 , string_concat/3 , optionStringList/3
optionStringList([],StrRes,StrRes).
optionStringList([Option|Oplist],StrAcum,StrRes):-
    optionGetElements(Option,_,OptionMens,_,_,_),
    string_concat(StrAcum,OptionMens,StrTemp),
    string_concat(StrTemp,"\n",StrAcumNew),
    optionStringList(Oplist,StrAcumNew,StrRes).

