
{$i deltics.strings.builders.inc}


  unit Deltics.Strings.Builders.Wide;


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
    TWideStringBuilder = class(TStringBuilder, IWideStringBuilder)
    protected
      function get_AsString: WideString;
    public
      procedure Append(aChar: WideChar); overload;
      procedure Append(const aString: WideString); overload;
      procedure Append(aStringList: TWideStrings); overload;
      procedure Append(aStringList: TWideStrings; aSeparator: WideChar); overload;
      procedure CloseParens;
      procedure OpenParens; overload;
      procedure OpenParens(const aParenChar: WideChar); overload;

    private
      fParens: WideCharArray;
    public
      property AsString: WideString read get_AsString;
    end;


implementation

  uses
    Deltics.Memory,
    Deltics.Strings.Builders.Exceptions;



{ TWideStringBuilder }

  function TWideStringBuilder.get_AsString: WideString;
  begin
    SetLength(result, Size div 2);
    Memory.Copy(Data, Size, Pointer(result));
  end;


  procedure TWideStringBuilder.OpenParens;
  begin
    OpenParens('(');
  end;


  procedure TWideStringBuilder.OpenParens(const aParenChar: WideChar);
  begin
    SetLength(fParens, Length(fParens) + 1);
    fParens[High(fParens)] := aParenChar;
    Append(aParenChar);
  end;


  procedure TWideStringBuilder.Append(aStringList: TWideStrings);
  var
    i: Integer;
  begin
    for i := 0 to Pred(aStringList.Count) do
      Append(aStringList[i]);
  end;


  procedure TWideStringBuilder.Append(aStringList: TWideStrings;
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


  procedure TWideStringBuilder.CloseParens;
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


  procedure TWideStringBuilder.Append(aChar: WideChar);
  begin
    AppendWord(Word(aChar));
  end;



  procedure TWideStringBuilder.Append(const aString: WideString);
  begin
    AppendBytes(Pointer(aString), Length(aString) * 2);
  end;







end.
