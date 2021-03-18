
{$i deltics.inc}

  unit Test.WideStringBuilder;


interface

  uses
    Deltics.Smoketest;


  type
    WideStringBuilder = class(TTest)
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
    Deltics.Strings.Builders;


{ WideStringBuilder }

  var
    sut: IWideStringBuilder;


  procedure WideStringBuilder.SetupMethod;
  begin
    sut := TWideStringBuilder.Create;
  end;



  procedure WideStringBuilder.AppendCharAppendsCorrectly;
  begin
    Test('AsString').Assert(sut.AsString).IsEmpty;

    sut.Append('A');
    Test('AsString').Assert(sut.AsString).Equals('A');

    sut.Append('B');
    Test('AsString').Assert(sut.AsString).Equals('AB');
  end;


  procedure WideStringBuilder.AppendStringAppendsCorrectly;
  begin
    Test('AsString').Assert(sut.AsString).IsEmpty;

    sut.Append('ABC');
    Test('AsString').Assert(sut.AsString).Equals('ABC');

    sut.Append('123');
    Test('AsString').Assert(sut.AsString).Equals('ABC123');
  end;


  procedure WideStringBuilder.ClearResetsTheBuilder;
  begin
    Test('AsString').Assert(sut.AsString).IsEmpty;

    sut.Append('anything');

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


  procedure WideStringBuilder.DefaultOpenParensFollowedByCloseParensAppendsEmptyParens;
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







end.

