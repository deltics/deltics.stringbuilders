
{$i deltics.stringbuilders.inc}


  unit Deltics.StringBuilders.Utf8;


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
    TUtf8StringBuilder = class(TStringBuilder, IUtf8StringBuilder)
    protected
      function get_AsString: Utf8String;
    public
      procedure Add(aChar: Utf8Char); overload;
      procedure Add(aChar: Utf8Char; const aRepeats: Integer); overload;
      procedure Add(const aString: Utf8String); overload;
      procedure Add(aStringList: TUtf8Strings); overload;
      procedure Add(aStringList: TUtf8Strings; aSeparator: Utf8Char); overload;
      procedure CloseParens;
      procedure OpenParens; overload;
      procedure OpenParens(const aParenChar: Utf8Char); overload;
      procedure Remove(const aNumChars: Integer);

    private
      fParens: Utf8Array;
    public
      property AsString: Utf8String read get_AsString;
    end;


implementation

  uses
    Deltics.Memory,
    Deltics.StringBuilders.Exceptions;



{ TUtf8StringBuilder }

  function TUtf8StringBuilder.get_AsString: Utf8String;
  begin
    SetLength(result, Size);
    Memory.Copy(Data, Size, @result[1]);
  end;


  procedure TUtf8StringBuilder.OpenParens;
  begin
    OpenParens('(');
  end;


  procedure TUtf8StringBuilder.OpenParens(const aParenChar: Utf8Char);
  begin
    SetLength(fParens, Length(fParens) + 1);
    fParens[High(fParens)] := aParenChar;
    Add(aParenChar);
  end;


  procedure TUtf8StringBuilder.Remove(const aNumChars: Integer);
  begin
    RemoveBytes(aNumChars);
  end;


  procedure TUtf8StringBuilder.Add(aStringList: TUtf8Strings);
  var
    i: Integer;
  begin
    for i := 0 to Pred(aStringList.Count) do
      Add(aStringList[i]);
  end;


  procedure TUtf8StringBuilder.Add(aStringList: TUtf8Strings;
                                   aSeparator: Utf8Char);
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


  procedure TUtf8StringBuilder.Add(      aChar: Utf8Char;
                                   const aRepeats: Integer);
  var
    i: Integer;
    s: Utf8String;
  begin
    SetLength(s, aRepeats);
    for i := 1 to aRepeats do
      s[i] := aChar;

    AddBytes(Pointer(s), aRepeats);
  end;


  procedure TUtf8StringBuilder.CloseParens;
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


  procedure TUtf8StringBuilder.Add(aChar: Utf8Char);
  begin
    AddByte(Byte(aChar));
  end;



  procedure TUtf8StringBuilder.Add(const aString: Utf8String);
  begin
    AddBytes(Pointer(aString), Length(aString));
  end;







end.
