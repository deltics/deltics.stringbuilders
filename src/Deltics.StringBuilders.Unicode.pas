
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
      procedure Add(aChar: WideChar); overload;
      procedure Add(aChar: WideChar; const aRepeats: Integer); overload;
      procedure Add(const aString: UnicodeString); overload;
      procedure Add(aStringList: TUnicodeStrings); overload;
      procedure Add(aStringList: TUnicodeStrings; aSeparator: WideChar); overload;
      procedure CloseParens;
      procedure OpenParens; overload;
      procedure OpenParens(const aParenChar: WideChar); overload;
      procedure Remove(const aNumChars: Integer);

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
    Add(aParenChar);
  end;


  procedure TUnicodeStringBuilder.Remove(const aNumChars: Integer);
  begin
    RemoveBytes(aNumChars * 2);
  end;


  procedure TUnicodeStringBuilder.Add(aStringList: TUnicodeStrings);
  var
    i: Integer;
  begin
    for i := 0 to Pred(aStringList.Count) do
      Add(aStringList[i]);
  end;


  procedure TUnicodeStringBuilder.Add(aStringList: TUnicodeStrings;
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


  procedure TUnicodeStringBuilder.Add(      aChar: WideChar;
                                      const aRepeats: Integer);
  var
    i: Integer;
    s: UnicodeString;
  begin
    SetLength(s, aRepeats);
    for i := 1 to aRepeats do
      s[i] := aChar;

    AddBytes(Pointer(s), aRepeats * 2);
  end;


  procedure TUnicodeStringBuilder.CloseParens;
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


  procedure TUnicodeStringBuilder.Add(aChar: WideChar);
  begin
    AddWord(Word(aChar));
  end;


  procedure TUnicodeStringBuilder.Add(const aString: UnicodeString);
  begin
    AddBytes(Pointer(aString), Length(aString) * 2);
  end;







end.
