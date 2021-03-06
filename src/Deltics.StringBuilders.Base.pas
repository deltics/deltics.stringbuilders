
{$i deltics.stringbuilders.inc}


  unit Deltics.StringBuilders.Base;


interface

  uses
    Classes,
    SysUtils,
    Deltics.InterfacedObjects,
    Deltics.StringLists,
    Deltics.StringBuilders.Interfaces,
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
      procedure AddByte(const aByte: Byte);
      procedure AddBytes(const aBuffer: Pointer; const aNumBytes: Integer);
      procedure AddWord(const aWord: Word);
      procedure RemoveBytes(const aNumBytes: Integer);
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
    Deltics.Memory,
    Deltics.StringBuilders.Exceptions;



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


  procedure TStringBuilder.RemoveBytes(const aNumBytes: Integer);
  begin
    if aNumBytes > fSize then
      raise EStringBuilderException.Create('Attempt to remove more characters than have been added');

    Dec(fSize, aNumBytes);
    Dec(fCurr, aNumBytes);
  end;


  procedure TStringBuilder.set_Capacity(const aValue: Integer);
  begin
    if aValue <= fCapacity then
      EXIT;

    fCapacity := aValue;

    ReallocMem(fData, fCapacity);

    fCurr := PByte(Memory.Offset(Data, Size));
  end;


  procedure TStringBuilder.AddByte(const aByte: Byte);
  begin
    if Size = Capacity then
      IncreaseCapacity;

    fCurr^ := aByte;

    Inc(fCurr);
    Inc(fSize);
  end;


  procedure TStringBuilder.AddBytes(const aBuffer: Pointer;
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


  procedure TStringBuilder.AddWord(const aWord: Word);
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
