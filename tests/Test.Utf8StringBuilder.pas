
{$i deltics.inc}

  unit Test.Utf8StringBuilder;


interface

  uses
    Deltics.Smoketest;


  type
    Utf8StringBuilder = class(TTest)
      procedure SetupMethod;

      procedure AppendCharAppendsCorrectly;
      procedure AppendStringAppendsCorrectly;
      procedure ClearResetsTheBuilder;
      procedure CloseParensMatchesParenCharUsedInOpenParens;
      procedure DefaultOpenParensFollowedByCloseParensAppendsEmptyParens;
      procedure MismatchedCloseParensRaisesEStringBuilderException;
    end;




implementation

  uses
    SysUtils,
    Deltics.StringBuilders;


{ Utf8StringBuilder }

  var
    sut: IUtf8StringBuilder;


  procedure Utf8StringBuilder.SetupMethod;
  begin
    sut := TUtf8StringBuilder.Create;
  end;



  procedure Utf8StringBuilder.AppendCharAppendsCorrectly;
  begin
    Test('AsString').AssertUtf8(sut.AsString).IsEmpty;

    sut.Append('A');
    Test('AsString').AssertUtf8(sut.AsString).Equals('A');

    sut.Append('B');
    Test('AsString').AssertUtf8(sut.AsString).Equals('AB');
  end;


  procedure Utf8StringBuilder.AppendStringAppendsCorrectly;
  begin
    Test('AsString').AssertUtf8(sut.AsString).IsEmpty;

    sut.Append('ABC');
    Test('AsString').AssertUtf8(sut.AsString).Equals('ABC');

    sut.Append('123');
    Test('AsString').AssertUtf8(sut.AsString).Equals('ABC123');
  end;


  procedure Utf8StringBuilder.ClearResetsTheBuilder;
  begin
    Test('AsString').AssertUtf8(sut.AsString).IsEmpty;

    sut.Append('anything');

    Test('AsString').AssertUtf8(sut.AsString).Equals('anything');

    sut.Clear;

    Test('AsString').AssertUtf8(sut.AsString).IsEmpty;
  end;


  procedure Utf8StringBuilder.CloseParensMatchesParenCharUsedInOpenParens;
  begin
    sut.OpenParens('(');
    sut.CloseParens;
    Test('AsString').AssertUtf8(sut.AsString).Equals('()');

    sut.Clear;
    sut.OpenParens('<');
    sut.CloseParens;
    Test('AsString').AssertUtf8(sut.AsString).Equals('<>');

    sut.Clear;
    sut.OpenParens('[');
    sut.CloseParens;
    Test('AsString').AssertUtf8(sut.AsString).Equals('[]');

    sut.Clear;
    sut.OpenParens('{');
    sut.CloseParens;
    Test('AsString').AssertUtf8(sut.AsString).Equals('{}');

    sut.Clear;
    sut.OpenParens('#');
    sut.CloseParens;
    Test('AsString').AssertUtf8(sut.AsString).Equals('##');
  end;


  procedure Utf8StringBuilder.DefaultOpenParensFollowedByCloseParensAppendsEmptyParens;
  begin
    sut.OpenParens;
    sut.CloseParens;

    Test('AsString').AssertUtf8(sut.AsString).Equals('()');
  end;


  procedure Utf8StringBuilder.MismatchedCloseParensRaisesEStringBuilderException;
  begin
    Test.Raises(EStringBuilderException, 'CloseParens called with no corresponding OpenParens');

    sut.CloseParens;
  end;







end.

