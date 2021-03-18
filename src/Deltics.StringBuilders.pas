
{$i deltics.stringbuilders.inc}


  unit Deltics.StringBuilders;


interface

  uses
    Classes,
    SysUtils,
    Deltics.StringBuilders.Exceptions,
    Deltics.StringBuilders.Interfaces,
    Deltics.StringBuilders.Ansi,
    Deltics.StringBuilders.Unicode,
    Deltics.StringBuilders.Utf8,
    Deltics.StringBuilders.Wide;



  type
    EStringBuilderException = Deltics.StringBuilders.Exceptions.EStringBuilderException;

    IAnsiStringBuilder    = Deltics.StringBuilders.Interfaces.IAnsiStringBuilder;
    IUnicodeStringBuilder = Deltics.StringBuilders.Interfaces.IUnicodeStringBuilder;
    IUtf8StringBuilder    = Deltics.StringBuilders.Interfaces.IUtf8StringBuilder;
    IWideStringBuilder    = Deltics.StringBuilders.Interfaces.IWideStringBuilder;

    TAnsiStringBuilder    = Deltics.StringBuilders.Ansi.TAnsiStringBuilder;
    TUnicodeStringBuilder = Deltics.StringBuilders.Unicode.TUnicodeStringBuilder;
    TUtf8StringBuilder    = Deltics.StringBuilders.Utf8.TUtf8StringBuilder;
    TWideStringBuilder    = Deltics.StringBuilders.Wide.TWideStringBuilder;




implementation




end.
