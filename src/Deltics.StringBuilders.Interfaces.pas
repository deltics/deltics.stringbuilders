
{$i deltics.stringbuilders.inc}

  unit Deltics.StringBuilders.Interfaces;


interface

  uses
    Deltics.StringLists,
    Deltics.StringTypes;


  type
    IStringBuilderBase = interface
    ['{555D43B2-C802-4497-AF1C-D2F51918019F}']
      function get_Capacity: Integer;
      function get_Size: Integer;

      procedure Clear;

      property Capacity: Integer read get_Capacity;
      property Size: Integer read get_Size;
    end;



    IAnsiStringBuilder = interface(IStringBuilderBase)
    ['{05EA2CBB-95D5-4FED-A2A0-DE07289A4D1B}']
      function get_AsString: AnsiString;

      procedure Add(aChar: AnsiChar); overload;
      procedure Add(aChar: AnsiChar; const aRepeats: Integer); overload;
      procedure Add(const aString: AnsiString); overload;
      procedure Add(aStringList: TAnsiStrings); overload;
      procedure Add(aStringList: TAnsiStrings; aSeparator: AnsiChar); overload;
      procedure CloseParens;
      procedure OpenParens; overload;
      procedure OpenParens(const aParenChar: AnsiChar); overload;
      procedure Remove(const aNumChars: Integer);

      property AsString: AnsiString read get_AsString;
    end;



    IUnicodeStringBuilder = interface(IStringBuilderBase)
    ['{BF3E62A9-4825-4EDB-895E-57E5BC690C7E}']
      function get_AsString: UnicodeString;

      procedure Add(aChar: WideChar); overload;
      procedure Add(aChar: WideChar; const aRepeats: Integer); overload;
      procedure Add(const aString: UnicodeString); overload;
      procedure Add(aStringList: TUnicodeStrings); overload;
      procedure Add(aStringList: TUnicodeStrings; aSeparator: WideChar); overload;
      procedure CloseParens;
      procedure OpenParens; overload;
      procedure OpenParens(const aParenChar: WideChar); overload;
      procedure Remove(const aNumChars: Integer);

      property AsString: UnicodeString read get_AsString;
    end;


    IUtf8StringBuilder = interface(IStringBuilderBase)
    ['{05EA2CBB-95D5-4FED-A2A0-DE07289A4D1B}']
      function get_AsString: Utf8String;

      procedure Add(aChar: Utf8Char); overload;
      procedure Add(aChar: Utf8Char; const aRepeats: Integer); overload;
      procedure Add(const aString: Utf8String); overload;
      procedure Add(aStringList: TUtf8Strings); overload;
      procedure Add(aStringList: TUtf8Strings; aSeparator: Utf8Char); overload;
      procedure CloseParens;
      procedure OpenParens; overload;
      procedure OpenParens(const aParenChar: Utf8Char); overload;
      procedure Remove(const aNumChars: Integer);

      property AsString: Utf8String read get_AsString;
    end;


    IWideStringBuilder = interface(IStringBuilderBase)
    ['{985B178D-2CB5-44CD-959E-499915D8ECDA}']
      function get_AsString: WideString;

      procedure Add(aChar: WideChar); overload;
      procedure Add(aChar: WideChar; const aRepeats: Integer); overload;
      procedure Add(const aString: WideString); overload;
      procedure Add(aStringList: TWideStrings); overload;
      procedure Add(aStringList: TWideStrings; aSeparator: WideChar); overload;
      procedure CloseParens;
      procedure OpenParens; overload;
      procedure OpenParens(const aParenChar: WideChar); overload;
      procedure Remove(const aNumChars: Integer);

      property AsString: WideString read get_AsString;
    end;


  {$ifdef UNICODE}
    IStringBuilder = IUnicodeStringBuilder;
  {$else}
    IStringBuilder = IAnsiStringBuilder;
  {$endif}



implementation


end.
