
{$apptype CONSOLE}

  program test;


uses
  Deltics.Smoketest,
  Deltics.Strings.Builders in '..\src\Deltics.Strings.Builders.pas',
  Deltics.Strings.Builders.Base in '..\src\Deltics.Strings.Builders.Base.pas',
  Deltics.Strings.Builders.Exceptions in '..\src\Deltics.Strings.Builders.Exceptions.pas',
  Deltics.Strings.Builders.Interfaces in '..\src\Deltics.Strings.Builders.Interfaces.pas',
  Deltics.Strings.Builders.Ansi in '..\src\Deltics.Strings.Builders.Ansi.pas',
  Deltics.Strings.Builders.Unicode in '..\src\Deltics.Strings.Builders.Unicode.pas',
  Deltics.Strings.Builders.Utf8 in '..\src\Deltics.Strings.Builders.Utf8.pas',
  Deltics.Strings.Builders.Wide in '..\src\Deltics.Strings.Builders.Wide.pas',
  Test.AnsiStringBuilder in 'Test.AnsiStringBuilder.pas',
  Test.UnicodeStringBuilder in 'Test.UnicodeStringBuilder.pas',
  Test.Utf8StringBuilder in 'Test.Utf8StringBuilder.pas',
  Test.WideStringBuilder in 'Test.WideStringBuilder.pas';

begin
  TestRun.Test(AnsiStringBuilder);
  TestRun.Test(UnicodeStringBuilder);
  TestRun.Test(Utf8StringBuilder);
  TestRun.Test(WideStringBuilder);
end.
