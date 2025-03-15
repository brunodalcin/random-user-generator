unit UFrmNavFavoriteUsers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmNavFavoriteUsers = class(TForm)
    grdFavUser: TDBGrid;
    Bevel3: TBevel;
    btnCsv: TButton;
    btnNavFavorites: TButton;
    dsFavUser: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnNavFavoritesClick(Sender: TObject);
    procedure btnCsvClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNavFavoriteUsers: TfrmNavFavoriteUsers;

implementation

uses UfrmProcessGenerateUser;

{$R *.dfm}

procedure TfrmNavFavoriteUsers.btnCsvClick(Sender: TObject);
var
  SaveDialog: TSaveDialog;
  CSVFile: TextFile;
  FileName: string;
  i: Integer;
begin
  if frmProcessGenerateUser.cdsFavUser.RecordCount = 0 then
  begin
    ShowMessage('No favorites to export.');
    Exit;
  end;

  // create dialog
  SaveDialog := TSaveDialog.Create(nil);
  try
    SaveDialog.Filter := 'CSV Files (*.csv)|*.csv';
    SaveDialog.DefaultExt := 'csv';
    SaveDialog.FileName := 'Favorites.csv';

    if not SaveDialog.Execute then
      Exit;

    FileName := SaveDialog.FileName;

    AssignFile(CSVFile, FileName);
    Rewrite(CSVFile);

    try
      // write headers
      for i := 0 to frmProcessGenerateUser.cdsFavUser.FieldCount - 1 do
      begin
        Write(CSVFile, frmProcessGenerateUser.cdsFavUser.Fields[i].FieldName);
        if i < frmProcessGenerateUser.cdsFavUser.FieldCount - 1 then
          Write(CSVFile, ',');
      end;
      Writeln(CSVFile);

      // write data
      frmProcessGenerateUser.cdsFavUser.First;
      while not frmProcessGenerateUser.cdsFavUser.Eof do
      begin
        for i := 0 to frmProcessGenerateUser.cdsFavUser.FieldCount - 1 do
        begin
          Write(CSVFile, frmProcessGenerateUser.cdsFavUser.Fields[i].AsString);
          if i < frmProcessGenerateUser.cdsFavUser.FieldCount - 1 then
            Write(CSVFile, ',');
        end;
        Writeln(CSVFile);
        frmProcessGenerateUser.cdsFavUser.Next;
      end;

      ShowMessage('Exported to: ' + FileName);
    finally
      CloseFile(CSVFile);
    end;
  finally
    SaveDialog.Free; // free memory
  end;
end;

procedure TfrmNavFavoriteUsers.btnNavFavoritesClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmNavFavoriteUsers.FormCreate(Sender: TObject);
begin
  dsFavUser.Dataset := frmProcessGenerateUser.cdsFavUser;
  grdFavUser.DataSource := dsFavUser;
end;

end.
