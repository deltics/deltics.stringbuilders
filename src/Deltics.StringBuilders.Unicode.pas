
{$i deltics.stringbuilders.inc}


  unit Deltics.StringBuilders.Unicode;


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
    TUnicodeStringBuilder = class(TStringBuilder, IUnicodeStringBuilder)
    protected
      function get_AsString: UnicodeString;
    public
      procedure Append(aChar: WideChar); overload;
      procedure Append(const aString: UnicodeString); overload;
      procedure Append(aStringList: TUnicodeStrings); overload;
      procedure Append(aStringList: TUnicodeStrings; aSeparator: WideChar); overload;
      procedure CloseParens;
      procedure OpenParens; overload;
      procedure OpenParens(const aParenChar: WideChar); overload;

    private
      fParens: WideCharArray;
    public
      property AsString: UnicodeString read get_AsString;
    end;


implementation

  uses
    Deltics.Memory,
    Deltics.StringBuilders.Exceptions;



{ TUnicodeStringBuilder }

  function TUnicodeStringBuilder.get_AsString: UnicodeString;
  begin
    SetLength(result, Size div 2);
    Memory.Copy(Data, Size, Pointer(result));
  end;


  procedure TUnicodeStringBuilder.OpenParens;
  begin
    OpenParens(WideChar('('));
  end;


  procedure TUnicodeStringBuilder.OpenParens(const aParenChar: WideChar);
  begin
    SetLength(fParens, Length(fParens) + 1);
    fParens[High(fParens)] := aParenChar;
    Append(aParenChar);
  end;


  procedure TUnicodeStringBuilder.Append(aStringList: TUnicodeStrings);
  var
    i: Integer;
  begin
    for i := 0 to Pred(aStringList.Count) do
      Append(aStringList[i]);
  end;


  procedure TUnicodeStringBuilder.Append(aStringList: TUnicodeStrings;
                                         aSeparator: WideChar);
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


  procedure TUnicodeStringBuilder.CloseParens;
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


  procedure TUnicodeStringBuilder.Append(aChar: WideChar);
  begin
    AppendWord(Word(aChar));
  end;


  procedure TUnicodeStringBuilder.Append(const aString: UnicodeString);
  begin
    AppendBytes(Pointer(aString), Length(aString) * 2);
  end;







end.
