
{$i deltics.stringbuilders.inc}


  unit Deltics.StringBuilders.Ansi;


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
    TAnsiStringBuilder = class(TStringBuilder, IAnsiStringBuilder)
    protected
      function get_AsString: AnsiString;
    public
      procedure Add(aChar: AnsiChar); overload;
      procedure Add(aChar: AnsiChar; const aRepeats: Integer); overload;
      procedure Add(const aString: AnsiString); overload;
      procedure Add(aStringList: TAnsiStrings); overload;
      procedure Add(aStringList: TAnsiStrings; aSeparator: AnsiChar); overload;
      procedure CloseParens;
      procedure OpenParens; overload;
      procedure OpenParens(const aParenChar: AnsiChar); overload;
      procedure Remove(const aNumChars: Integer);

    private
      fParens: AnsiCharArray;
    public
      property AsString: AnsiString read get_AsString;
    end;


implementation

  uses
    Deltics.Memory,
    Deltics.StringBuilders.Exceptions;



{ TAnsiStringBuilder }

  function TAnsiStringBuilder.get_AsString: AnsiString;
  begin
    SetLength(result, Size);
    Memory.Copy(Data, Size, @result[1]);
  end;


  procedure TAnsiStringBuilder.OpenParens;
  begin
    OpenParens('(');
  end;


  procedure TAnsiStringBuilder.OpenParens(const aParenChar: AnsiChar);
  begin
    SetLength(fParens, Length(fParens) + 1);
    fParens[High(fParens)] := aParenChar;
    Add(aParenChar);
  end;


  procedure TAnsiStringBuilder.Remove(const aNumChars: Integer);
  begin
    RemoveBytes(aNumChars);
  end;


  procedure TAnsiStringBuilder.Add(aStringList: TAnsiStrings);
  var
    i: Integer;
  begin
    for i := 0 to Pred(aStringList.Count) do
      Add(aStringList[i]);
  end;


  procedure TAnsiStringBuilder.Add(aStringList: TAnsiStrings;
                                      aSeparator: AnsiChar);
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


  procedure TAnsiStringBuilder.Add(      aChar: AnsiChar;
                                   const aRepeats: Integer);
  var
    i: Integer;
    s: AnsiString;
  begin
    SetLength(s, aRepeats);
    for i := 1 to aRepeats do
      s[i] := aChar;

    AddBytes(Pointer(s), aRepeats);
  end;


  procedure TAnsiStringBuilder.CloseParens;
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


  procedure TAnsiStringBuilder.Add(aChar: AnsiChar);
  begin
    AddByte(Byte(aChar));
  end;


  procedure TAnsiStringBuilder.Add(const aString: AnsiString);
  begin
    AddBytes(Pointer(aString), Length(aString));
  end;





end.
