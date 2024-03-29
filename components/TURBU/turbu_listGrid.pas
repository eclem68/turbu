unit turbu_listGrid;

interface

uses
   Classes, Grids, DBGrids, DBCtrls;

type
   TRpgListGrid = class(TDBGrid)
   private
      { Private declarations }
      FOnRowEnter: TMovedEvent;
      const DEFAULT_OPTIONS = [dgTitles, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit];
   protected
      { Protected declarations }
      procedure Scroll(Distance: Integer); override;
   public
      { Public declarations }
      constructor Create(AOwner: TComponent); override;

      property Row;
      property RowCount;
   published
      { Published declarations }
      property OnRowEnter: TMovedEvent read FOnRowEnter write FOnRowEnter;
      property Options default DEFAULT_OPTIONS;
   end;

   TDBLookupComboBox = class(DBCtrls.TDBLookupComboBox)
   protected
      procedure KeyDown(var Key: Word; Shift: TShiftState); override;
   end;

procedure Register;

implementation

procedure Register;
begin
   RegisterComponents('TURBU', [TRpgListGrid]);
end;

{ TRpgListGrid }

constructor TRpgListGrid.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   self.Options := DEFAULT_OPTIONS;
end;

procedure TRpgListGrid.Scroll(Distance: Integer);
var
   oldRow: integer;
begin
   oldRow := Row;
   inherited Scroll(Distance);
   if Assigned(FOnRowEnter) then
      FOnRowEnter(self, oldRow, self.Row);
end;

{ TDBLookupComboBox }

procedure TDBLookupComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
   if self.DataLink.DataSet.CanModify then
      inherited KeyDown(key, shift);
end;

end.
