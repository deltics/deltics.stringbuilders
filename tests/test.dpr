
{$apptype CONSOLE}

  program test;


uses
  Deltics.Smoketest,
  Test.AnsiStringBuilder in 'Test.AnsiStringBuilder.pas',
  Test.UnicodeStringBuilder in 'Test.UnicodeStringBuilder.pas',
  Test.Utf8StringBuilder in 'Test.Utf8StringBuilder.pas',
  Test.WideStringBuilder in 'Test.WideStringBuilder.pas',
  Deltics.StringBuilders.Ansi in '..\src\Deltics.StringBuilders.Ansi.pas',
  Deltics.StringBuilders.Base in '..\src\Deltics.StringBuilders.Base.pas',
  Deltics.StringBuilders.Exceptions in '..\src\Deltics.StringBuilders.Exceptions.pas',
  Deltics.StringBuilders.Interfaces in '..\src\Deltics.StringBuilders.Interfaces.pas',
  Deltics.StringBuilders in '..\src\Deltics.StringBuilders.pas',
  Deltics.StringBuilders.Unicode in '..\src\Deltics.StringBuilders.Unicode.pas',
  Deltics.StringBuilders.Utf8 in '..\src\Deltics.StringBuilders.Utf8.pas',
  Deltics.StringBuilders.Wide in '..\src\Deltics.StringBuilders.Wide.pas';

begin
  TestRun.Test(AnsiStringBuilder);
  TestRun.Test(UnicodeStringBuilder);
  TestRun.Test(Utf8StringBuilder);
  TestRun.Test(WideStringBuilder);
end.
