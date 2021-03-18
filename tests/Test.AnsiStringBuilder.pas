
{$i deltics.inc}

  unit Test.AnsiStringBuilder;


interface

  uses
    Deltics.Smoketest;


  type
    AnsiStringBuilder = class(TTest)
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


{ AnsiStringBuilder }

  var
    sut: IAnsiStringBuilder;


  procedure AnsiStringBuilder.SetupMethod;
  begin
    sut := TAnsiStringBuilder.Create;
  end;



  procedure AnsiStringBuilder.AppendCharAppendsCorrectly;
  begin
    Test('AsString').Assert(sut.AsString).IsEmpty;

    sut.Append('A');
    Test('AsString').Assert(sut.AsString).Equals('A');

    sut.Append('B');
    Test('AsString').Assert(sut.AsString).Equals('AB');
  end;


  procedure AnsiStringBuilder.AppendStringAppendsCorrectly;
  begin
    Test('AsString').Assert(sut.AsString).IsEmpty;

    sut.Append('ABC');
    Test('AsString').Assert(sut.AsString).Equals('ABC');

    sut.Append('123');
    Test('AsString').Assert(sut.AsString).Equals('ABC123');
  end;


  procedure AnsiStringBuilder.ClearResetsTheBuilder;
  begin
    Test('AsString').Assert(sut.AsString).IsEmpty;

    sut.Append('anything');

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


  procedure AnsiStringBuilder.DefaultOpenParensFollowedByCloseParensAppendsEmptyParens;
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







end.
