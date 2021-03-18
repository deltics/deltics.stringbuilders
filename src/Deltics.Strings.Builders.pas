
{$i deltics.strings.builders.inc}


  unit Deltics.Strings.Builders;


interface

  uses
    Classes,
    SysUtils,
    Deltics.Strings.Builders.Exceptions,
    Deltics.Strings.Builders.Interfaces,
    Deltics.Strings.Builders.Ansi,
    Deltics.Strings.Builders.Unicode,
    Deltics.Strings.Builders.Utf8,
    Deltics.Strings.Builders.Wide;



  type
    EStringBuilderException = Deltics.Strings.Builders.Exceptions.EStringBuilderException;

    IAnsiStringBuilder    = Deltics.Strings.Builders.Interfaces.IAnsiStringBuilder;
    IUnicodeStringBuilder = Deltics.Strings.Builders.Interfaces.IUnicodeStringBuilder;
    IUtf8StringBuilder    = Deltics.Strings.Builders.Interfaces.IUtf8StringBuilder;
    IWideStringBuilder    = Deltics.Strings.Builders.Interfaces.IWideStringBuilder;

    TAnsiStringBuilder    = Deltics.Strings.Builders.Ansi.TAnsiStringBuilder;
    TUnicodeStringBuilder = Deltics.Strings.Builders.Unicode.TUnicodeStringBuilder;
    TUtf8StringBuilder    = Deltics.Strings.Builders.Utf8.TUtf8StringBuilder;
    TWideStringBuilder    = Deltics.Strings.Builders.Wide.TWideStringBuilder;




implementation




end.
