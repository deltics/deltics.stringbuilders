
{$i deltics.inc}

  unit Test.WideStringBuilder;


interface

  uses
    Deltics.Smoketest;


  type
    WideStringBuilder = class(TTest)
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


{ WideStringBuilder }

  var
    sut: IWideStringBuilder;


  procedure WideStringBuilder.SetupMethod;
  begin
    sut := TWideStringBuilder.Create;
  end;



  procedure WideStringBuilder.AddCharAddsCorrectly;
  begin
    Test('AsString').Assert(sut.AsString).IsEmpty;

    sut.Add('A');
    Test('AsString').Assert(sut.AsString).Equals('A');

    sut.Add('B');
    Test('AsString').Assert(sut.AsString).Equals('AB');
  end;


  procedure WideStringBuilder.AddRepeatsAddsCorrectNumberOfChars;
  begin
    sut.Add(WideChar('x'), 4);
    Test('AsString').Assert(sut.AsString).Equals('xxxx');
  end;


  procedure WideStringBuilder.AddStringAddsCorrectly;
  begin
    Test('AsString').Assert(sut.AsString).IsEmpty;

    sut.Add('ABC');
    Test('AsString').Assert(sut.AsString).Equals('ABC');

    sut.Add('123');
    Test('AsString').Assert(sut.AsString).Equals('ABC123');
  end;


  procedure WideStringBuilder.ClearResetsTheBuilder;
  begin
    Test('AsString').Assert(sut.AsString).IsEmpty;

    sut.Add('anything');

    Test('AsString').Assert(sut.AsString).Equals('anything');

    sut.Clear;

    Test('AsString').Assert(sut.AsString).IsEmpty;
  end;


  procedure WideStringBuilder.CloseParensMatchesParenCharUsedInOpenParens;
  begin
    sut.OpenParens(WideChar('('));
    sut.CloseParens;
    Test('AsString').Assert(sut.AsString).Equals('()');

    sut.Clear;
    sut.OpenParens(WideChar('<'));
    sut.CloseParens;
    Test('AsString').Assert(sut.AsString).Equals('<>');

    sut.Clear;
    sut.OpenParens(WideChar('['));
    sut.CloseParens;
    Test('AsString').Assert(sut.AsString).Equals('[]');

    sut.Clear;
    sut.OpenParens(WideChar('{'));
    sut.CloseParens;
    Test('AsString').Assert(sut.AsString).Equals('{}');

    sut.Clear;
    sut.OpenParens(WideChar('#'));
    sut.CloseParens;
    Test('AsString').Assert(sut.AsString).Equals('##');
  end;


  procedure WideStringBuilder.DefaultOpenParensFollowedByCloseParensAddsEmptyParens;
  begin
    sut.OpenParens;
    sut.CloseParens;

    Test('AsString').Assert(sut.AsString).Equals('()');
  end;


  procedure WideStringBuilder.MismatchedCloseParensRaisesEStringBuilderException;
  begin
    Test.Raises(EStringBuilderException, 'CloseParens called with no corresponding OpenParens');

    sut.CloseParens;
  end;


  procedure WideStringBuilder.RemoveRemovesCorrectNumberOfChars;
  begin
    sut.Add('The quick brown fox');
    sut.Remove(4);

    Test('AsString').Assert(sut.AsString).Equals('The quick brown');
  end;


  procedure WideStringBuilder.RemovingExcessCharactersRaisesEStringBuilderException;
  begin
    Test.Raises(EStringBuilderException);

    sut.Remove(1);
  end;



end.

