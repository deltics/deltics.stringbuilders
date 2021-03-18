
{$i deltics.stringbuilders.inc}


  unit Deltics.StringBuilders.Wide;


interface

  uses
    Classes,
    SysUtils,
    Deltics.InterfacedObjects,
    Deltics.StringLists,
    Deltics.StringBuilders.Base,
    Deltics.StringBuilders.Interfaces,
    Deltics.StringTypes;


  type
    TWideStringBuilder = class(TStringBuilder, IWideStringBuilder)
    protected
      function get_AsString: WideString;
    public
      procedure Add(aChar: WideChar); overload;
      procedure Add(aChar: WideChar; const aRepeats: Integer); overload;
      procedure Add(const aString: WideString); overload;
      procedure Add(aStringList: TWideStrings); overload;
      procedure Add(aStringList: TWideStrings; aSeparator: WideChar); overload;
      procedure CloseParens;
      procedure OpenParens; overload;
      procedure OpenParens(const aParenChar: WideChar); overload;
      procedure Remove(const aNumChars: Integer);

    private
      fParens: WideCharArray;
    public
      property AsString: WideString read get_AsString;
    end;


implementation

  uses
    Deltics.Memory,
    Deltics.StringBuilders.Exceptions;



{ TWideStringBuilder }

  function TWideStringBuilder.get_AsString: WideString;
  begin
    SetLength(result, Size div 2);
    Memory.Copy(Data, Size, Pointer(result));
  end;


  procedure TWideStringBuilder.OpenParens;
  begin
    OpenParens(WideChar('('));
  end;


  procedure TWideStringBuilder.OpenParens(const aParenChar: WideChar);
  begin
    SetLength(fParens, Length(fParens) + 1);
    fParens[High(fParens)] := aParenChar;
    Add(aParenChar);
  end;


  procedure TWideStringBuilder.Remove(const aNumChars: Integer);
  begin
    RemoveBytes(aNumChars * 2);
  end;


  procedure TWideStringBuilder.Add(aStringList: TWideStrings);
  var
    i: Integer;
  begin
    for i := 0 to Pred(aStringList.Count) do
      Add(aStringList[i]);
  end;


  procedure TWideStringBuilder.Add(aStringList: TWideStrings;
                                         aSeparator: WideChar);
  var
    i, maxi: Integer;
  begin
    maxi := Pred(aStringList.Count);

    case maxi of
       0  : Add(aStringList[maxi]);
      -1  : EXIT;
    else
      for i := 0 to maxi - 1 do
      begin
        Add(aStringList[i]);
        Add(aSeparator);
      end;
      Add(aStringList[maxi]);
    end;
  end;


  procedure TWideStringBuilder.Add(aChar: WideChar; const aRepeats: Integer);
  var
    i: Integer;
    s: WideString;
  begin
    SetLength(s, aRepeats);
    for i := 1 to aRepeats do
      s[i] := aChar;

    AddBytes(Pointer(s), aRepeats * 2);
  end;


  procedure TWideStringBuilder.CloseParens;
  begin
    if Length(fParens) = 0 then
      raise EStringBuilderException.Create('CloseParens called with no corresponding OpenParens');

    case fParens[High(fParens)] of
      '(' : Add(')');
      '{' : Add('}');
      '[' : Add(']');
      '<' : Add('>');
    else
      Add(fParens[High(fParens)]);
    end;
    SetLength(fParens, Length(fParens) - 1);
  end;


  procedure TWideStringBuilder.Add(aChar: WideChar);
  begin
    AddWord(Word(aChar));
  end;



  procedure TWideStringBuilder.Add(const aString: WideString);
  begin
    AddBytes(Pointer(aString), Length(aString) * 2);
  end;







end.
