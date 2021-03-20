
{$i deltics.inc}

  unit Test.Utf8StringBuilder;


interface

  uses
    Deltics.Smoketest;


  type
    Utf8StringBuilder = class(TTest)
      procedure SetupMethod;

      procedure AddCharAddsCorrectly;
      procedure AddStringAddsCorrectly;
      procedure ClearResetsTheBuilder;
      procedure CloseParensMatchesParenCharUsedInOpenParens;
      procedure DefaultOpenParensFollowedByCloseParensAddsEmptyParens;
      procedure MismatchedCloseParensRaisesEStringBuilderException;
      procedure AddRepeatsAddsCorrectNumberOfChars;
      procedure RemoveRemovesCorrectNumberOfChars;
      procedure RemovingExcessCharactersRaisesEStringBuilderException;
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



  procedure Utf8StringBuilder.AddCharAddsCorrectly;
  begin
    Test('AsString').AssertUtf8(sut.AsString).IsEmpty;

    sut.Add('A');
    Test('AsString').AssertUtf8(sut.AsString).Equals('A');

    sut.Add('B');
    Test('AsString').AssertUtf8(sut.AsString).Equals('AB');
  end;


  procedure Utf8StringBuilder.AddRepeatsAddsCorrectNumberOfChars;
  begin
    sut.Add('x', 4);
    Test('AsString').AssertUtf8(sut.AsString).Equals('xxxx');
  end;


  procedure Utf8StringBuilder.AddStringAddsCorrectly;
  begin
    Test('AsString').AssertUtf8(sut.AsString).IsEmpty;

    sut.Add('ABC');
    Test('AsString').AssertUtf8(sut.AsString).Equals('ABC');

    sut.Add('123');
    Test('AsString').AssertUtf8(sut.AsString).Equals('ABC123');
  end;


  procedure Utf8StringBuilder.ClearResetsTheBuilder;
  begin
    Test('AsString').AssertUtf8(sut.AsString).IsEmpty;

    sut.Add('anything');

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


  procedure Utf8StringBuilder.DefaultOpenParensFollowedByCloseParensAddsEmptyParens;
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


  procedure Utf8StringBuilder.RemoveRemovesCorrectNumberOfChars;
  begin
    sut.Add('The quick brown fox');
    sut.Remove(4);

    Test('AsString').AssertUtf8(sut.AsString).Equals('The quick brown');
  end;

  procedure Utf8StringBuilder.RemovingExcessCharactersRaisesEStringBuilderException;
  begin
    Test.Raises(EStringBuilderException);

    sut.Remove(1);
  end;



end.

