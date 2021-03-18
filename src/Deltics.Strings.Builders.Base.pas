
{$i deltics.strings.builders.inc}


  unit Deltics.Strings.Builders.Base;


interface

  uses
    Classes,
    SysUtils,
    Deltics.InterfacedObjects,
    Deltics.Strings.Lists,
    Deltics.Strings.Builders.Interfaces,
    Deltics.StringTypes;


  type
    TStringBuilder = class(TComInterfacedObject, IStringBuilderBase)
    protected
      function get_Capacity: Integer;
      function get_Size: Integer;
      procedure set_Capacity(const aValue: Integer);
    public
      procedure Clear;

    private
      fCapacity: Integer;
      fCurr: PByte;
      fData: Pointer;
      fIncrement: Integer;
      fSize: Integer;
      procedure IncreaseCapacity;
    protected
      procedure AppendByte(const aByte: Byte);
      procedure AppendBytes(const aBuffer: Pointer; const aNumBytes: Integer);
      procedure AppendWord(const aWord: Word);
    public
      constructor Create; overload;
      constructor Create(const aInitialCapacity: Integer); overload;
      constructor Create(const aInitialCapacity: Integer; const aIncrement: Integer); overload;
      destructor Destroy; override;
      property Capacity: Integer read fCapacity write set_Capacity;
      property Data: Pointer read fData;
      property Size: Integer read fSize;
    end;


implementation

  uses
    Deltics.Memory;



{ TStringBuilder }

  constructor TStringBuilder.Create;
  begin
    Create(1024, 0);
  end;


  constructor TStringBuilder.Create(const aInitialCapacity: Integer);
  begin
    Create(aInitialCapacity, 0);
  end;


  constructor TStringBuilder.Create(const aInitialCapacity: Integer;
                                    const aIncrement: Integer);
  begin
    inherited Create;

    fCapacity   := aInitialCapacity;
    fIncrement  := aIncrement;
    fSize       := 0;

    GetMem(fData, fCapacity);

    fCurr := PByte(fData);
  end;


  destructor TStringBuilder.Destroy;
  begin
    FreeMem(fData);

    inherited;
  end;


  function TStringBuilder.get_Capacity: Integer;
  begin
    result := fCapacity;
  end;


  function TStringBuilder.get_Size: Integer;
  begin
    result := fSize;
  end;


  procedure TStringBuilder.IncreaseCapacity;
  begin
    if fIncrement > 0 then
      Inc(fCapacity, fIncrement)
    else
      Inc(fCapacity, fCapacity);

    ReallocMem(fData, fCapacity);

    fCurr := PByte(Memory.Offset(Data, Size));
  end;


  procedure TStringBuilder.set_Capacity(const aValue: Integer);
  begin
    if aValue <= fCapacity then
      EXIT;

    fCapacity := aValue;

    ReallocMem(fData, fCapacity);

    fCurr := PByte(Memory.Offset(Data, Size));
  end;


  procedure TStringBuilder.AppendByte(const aByte: Byte);
  begin
    if Size = Capacity then
      IncreaseCapacity;

    fCurr^ := aByte;

    Inc(fCurr);
    Inc(fSize);
  end;


  procedure TStringBuilder.AppendBytes(const aBuffer: Pointer;
                                       const aNumBytes: Integer);
  begin
    if aNumBytes = 0 then
      EXIT;

    if Capacity - Size < aNumBytes then
      IncreaseCapacity;

    Memory.Copy(aBuffer, aNumBytes, fCurr);

    Inc(fCurr, aNumBytes);
    Inc(fSize, aNumBytes);
  end;


  procedure TStringBuilder.AppendWord(const aWord: Word);
  begin
    if Capacity - Size < 2 then
      IncreaseCapacity;

    PWord(fCurr)^ := aWord;

    Inc(fCurr, 2);
    Inc(fSize, 2);
  end;


  procedure TStringBuilder.Clear;
  begin
    fSize := 0;
    fCurr := PByte(fData);
  end;







end.
