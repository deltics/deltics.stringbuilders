
{$i deltics.inc}

  unit Test.AnsiStringBuilder;


interface

  uses
    Deltics.Smoketest;


  type
    AnsiStringBuilder = class(TTest)
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


{ AnsiStringBuilder }

  var
    sut: IAnsiStringBuilder;


  procedure AnsiStringBuilder.SetupMethod;
  begin
    sut := TAnsiStringBuilder.Create;
  end;



  procedure AnsiStringBuilder.AddCharAddsCorrectly;
  begin
    Test('AsString').Assert(sut.AsString).IsEmpty;

    sut.Add('A');
    Test('AsString').Assert(sut.AsString).Equals('A');

    sut.Add('B');
    Test('AsString').Assert(sut.AsString).Equals('AB');
  end;


  procedure AnsiStringBuilder.AddRepeatsAddsCorrectNumberOfChars;
  begin
    sut.Add('x', 4);
    Test('AsString').Assert(sut.AsString).Equals('xxxx');
  end;


  procedure AnsiStringBuilder.AddStringAddsCorrectly;
  begin
    Test('AsString').Assert(sut.AsString).IsEmpty;

    sut.Add('ABC');
    Test('AsString').Assert(sut.AsString).Equals('ABC');

    sut.Add('123');
    Test('AsString').Assert(sut.AsString).Equals('ABC123');
  end;


  procedure AnsiStringBuilder.ClearResetsTheBuilder;
  begin
    Test('AsString').Assert(sut.AsString).IsEmpty;

    sut.Add('anything');

    Test('AsString').Assert(sut.AsString).Equals('anything');

    sut.Clear;

    Test('AsString').Assert(sut.AsString).IsEmpty;
  end;


  procedure AnsiStringBuilder.CloseParensMatchesParenCharUsedInOpenParens;
  begin
    sut.OpenParens('(');
    sut.CloseParens;
    Test('AsString').Assert(sut.AsString).Equals('()');

    sut.Clear;
    sut.OpenParens('<');
    sut.CloseParens;
    Test('AsString').Assert(sut.AsString).Equals('<>');

    sut.Clear;
    sut.OpenParens('[');
    sut.CloseParens;
    Test('AsString').Assert(sut.AsString).Equals('[]');

    sut.Clear;
    sut.OpenParens('{');
    sut.CloseParens;
    Test('AsString').Assert(sut.AsString).Equals('{}');

    sut.Clear;
    sut.OpenParens('#');
    sut.CloseParens;
    Test('AsString').Assert(sut.AsString).Equals('##');
  end;


  procedure AnsiStringBuilder.DefaultOpenParensFollowedByCloseParensAddsEmptyParens;
  begin
    sut.OpenParens;
    sut.CloseParens;

    Test('AsString').Assert(sut.AsString).Equals('()');
  end;


  procedure AnsiStringBuilder.MismatchedCloseParensRaisesEStringBuilderException;
  begin
    Test.Raises(EStringBuilderException, 'CloseParens called with no corresponding OpenParens');

    sut.CloseParens;
  end;


  procedure AnsiStringBuilder.RemoveRemovesCorrectNumberOfChars;
  begin
    sut.Add('The quick brown fox');
    sut.Remove(4);

    Test('AsString').Assert(sut.AsString).Equals('The quick brown');
  end;


  procedure AnsiStringBuilder.RemovingExcessCharactersRaisesEStringBuilderException;
  begin
    Test.Raises(EStringBuilderException);

    sut.Remove(1);
  end;


end.
