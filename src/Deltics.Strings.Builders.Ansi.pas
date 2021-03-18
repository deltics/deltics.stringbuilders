
{$i deltics.strings.builders.inc}


  unit Deltics.Strings.Builders.Ansi;


interface

  uses
    Classes,
    SysUtils,
    Deltics.InterfacedObjects,
    Deltics.Strings.Lists,
    Deltics.Strings.Builders.Base,
    Deltics.Strings.Builders.Interfaces,
    Deltics.StringTypes;


  type
    TAnsiStringBuilder = class(TStringBuilder, IAnsiStringBuilder)
    protected
      function get_AsString: AnsiString;
    public
      procedure Append(aChar: AnsiChar); overload;
      procedure Append(const aString: AnsiString); overload;
      procedure Append(aStringList: TAnsiStrings); overload;
      procedure Append(aStringList: TAnsiStrings; aSeparator: AnsiChar); overload;
      procedure CloseParens;
      procedure OpenParens; overload;
      procedure OpenParens(const aParenChar: AnsiChar); overload;

    private
      fParens: AnsiCharArray;
    public
      property AsString: AnsiString read get_AsString;
    end;


implementation

  uses
    Deltics.Memory,
    Deltics.Strings.Builders.Exceptions;



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
    Append(aParenChar);
  end;


  procedure TAnsiStringBuilder.Append(aStringList: TAnsiStrings);
  var
    i: Integer;
  begin
    for i := 0 to Pred(aStringList.Count) do
      Append(aStringList[i]);
  end;


  procedure TAnsiStringBuilder.Append(aStringList: TAnsiStrings;
                                      aSeparator: AnsiChar);
  var
    i, maxi: Integer;
  begin
    maxi := Pred(aStringList.Count);

    case maxi of
       0  : Append(aStringList[maxi]);
      -1  : EXIT;
    else
      for i := 0 to maxi - 1 do
      begin
        Append(aStringList[i]);
        Append(aSeparator);
      end;
      Append(aStringList[maxi]);
    end;
  end;


  procedure TAnsiStringBuilder.CloseParens;
  begin
    if Length(fParens) = 0 then
      raise EStringBuilderException.Create('CloseParens called with no corresponding OpenParens');

    case fParens[High(fParens)] of
      '(' : Append(')');
      '{' : Append('}');
      '[' : Append(']');
      '<' : Append('>');
    else
      Append(fParens[High(fParens)]);
    end;
    SetLength(fParens, Length(fParens) - 1);
  end;


  procedure TAnsiStringBuilder.Append(aChar: AnsiChar);
  begin
    AppendByte(Byte(aChar));
  end;


  procedure TAnsiStringBuilder.Append(const aString: AnsiString);
  begin
    AppendBytes(Pointer(aString), Length(aString));
  end;





end.
