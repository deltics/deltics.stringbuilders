
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
      procedure Append(aChar: Utf8Char); overload;
      procedure Append(const aString: Utf8String); overload;
      procedure Append(aStringList: TUtf8Strings); overload;
      procedure Append(aStringList: TUtf8Strings; aSeparator: Utf8Char); overload;
      procedure CloseParens;
      procedure OpenParens; overload;
      procedure OpenParens(const aParenChar: Utf8Char); overload;

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
    Append(aParenChar);
  end;


  procedure TUtf8StringBuilder.Append(aStringList: TUtf8Strings);
  var
    i: Integer;
  begin
    for i := 0 to Pred(aStringList.Count) do
      Append(aStringList[i]);
  end;


  procedure TUtf8StringBuilder.Append(aStringList: TUtf8Strings;
                                      aSeparator: Utf8Char);
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


  procedure TUtf8StringBuilder.CloseParens;
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


  procedure TUtf8StringBuilder.Append(aChar: Utf8Char);
  begin
    AppendByte(Byte(aChar));
  end;



  procedure TUtf8StringBuilder.Append(const aString: Utf8String);
  begin
    AppendBytes(Pointer(aString), Length(aString));
  end;







end.
