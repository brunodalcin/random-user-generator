unit UFrmProcessGenerateUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, Vcl.ExtCtrls, Vcl.StdCtrls,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, Vcl.Imaging.jpeg,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  Vcl.Buttons, Data.DB, Datasnap.DBClient;

type
  TfrmProcessGenerateUser = class(TForm)
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    Image: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lbAddress: TLabel;
    lbPhone: TLabel;
    lbEmail: TLabel;
    lbUsername: TLabel;
    lbName: TLabel;
    Bevel3: TBevel;
    btnNewProfile: TButton;
    NetHTTPClient: TNetHTTPClient;
    btnFav: TButton;
    btnNavFavorites: TButton;
    cdsFavUser: TClientDataSet;
    procedure btnNewProfileClick(Sender: TObject);
    procedure btnFavClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNavFavoritesClick(Sender: TObject);
  private
    { Private declarations }
    procedure DownloadImg(URL: string) ;
  public
    { Public declarations }
  end;

var
  frmProcessGenerateUser: TfrmProcessGenerateUser;

implementation

uses UfrmNavFavoriteUsers;

{$R *.dfm}

procedure TfrmProcessGenerateUser.btnNavFavoritesClick(Sender: TObject);
begin
  if not Assigned(frmNavFavoriteUsers) then
    frmNavFavoriteUsers := TfrmNavFavoriteUsers.Create(self);
  frmNavFavoriteUsers.ShowModal;

end;

procedure TfrmProcessGenerateUser.btnNewProfileClick(Sender: TObject);
var
  JSONValue: TJSONValue;
  JSONObject: TJSONObject;
  JSONResults: TJSONArray;
begin
  RESTClient.BaseURL := 'https://randomuser.me/api/';
  RESTRequest.Execute;

  JSONValue := RESTResponse.JSONValue;
  if Assigned(JSONValue) and (JSONValue is TJSONObject) then
  begin
    JSONResults := (JSONValue as TJSONObject).GetValue<TJSONArray>('results');
    if JSONResults.Count > 0 then
    begin
      JSONObject := JSONResults.Items[0] as TJSONObject;

      // grabbing JSON values
      lbName.Caption := JSONObject.GetValue<TJSONObject>('name').GetValue<string>('first') + ' ' +
                           JSONObject.GetValue<TJSONObject>('name').GetValue<string>('last');
      lbUsername.Caption := JSONObject.GetValue<TJSONObject>('login').GetValue<string>('username');
      lbEmail.Caption := JSONObject.GetValue<string>('email');
      lbPhone.Caption := JSONObject.GetValue<string>('phone');
      lbAddress.Caption := JSONObject.GetValue<TJSONObject>('location').GetValue<string>('city') + ', ' +
                                  JSONObject.GetValue<TJSONObject>('location').GetValue<string>('country');

      // laod user img
      DownloadImg(JSONObject.GetValue<TJSONObject>('picture').GetValue<string>('large'));

    end;
  end;
  //reset btn
  btnFav.Caption := 'Favorite user';
  //cdsFavUser.FieldDefs.Clear;
  //cdsFavUser.FieldDefs.Add('ID', ftInteger);
  //cdsFavUser.FieldDefs.Add('Nome', ftString, 100);
  //cdsFavUser.CreateDataSet;

end;

procedure TfrmProcessGenerateUser.btnFavClick(Sender: TObject);
begin
  //if its not in the FAV, ill append the register
  if lbUsername.Caption <> '...' then begin  //super simple validation to not let the user favorite without a user
    if not cdsFavUser.Locate('username', lbUsername.Caption, []) then
    begin
     cdsFavUser.Append;
     cdsFavUser.FieldByName('Name').AsString := lbName.Caption;
     cdsFavUser.FieldByName('Username').AsString := lbUsername.Caption;
     cdsFavUser.FieldByName('Email').AsString := lbEmail.Caption;
     cdsFavUser.FieldByName('Phone').AsString := lbPhone.Caption;
     cdsFavUser.FieldByName('Address').AsString := lbAddress.Caption;
     cdsFavUser.Post;

      btnFav.Caption := 'UNFavorite user';
    end
    //if its already a favorite, ill delete from the dataset
    else begin
     if cdsFavUser.Locate('Username', lbUsername.Caption, []) then
       cdsFavUser.Delete;
     btnFav.Caption := 'Favorite user';
    end;
  end;


end;

procedure TfrmProcessGenerateUser.DownloadImg(URL: string);
var
  HTTP: TNetHTTPClient;
  MemStream: TMemoryStream;
  JPG: TJPEGImage;
begin
  HTTP := TNetHTTPClient.Create(nil);
  MemStream := TMemoryStream.Create;
  JPG := TJPEGImage.Create;
  try
    // download img
    HTTP.Get(URL, MemStream);
    MemStream.Position := 0;

    // load img em JPG
    JPG.LoadFromStream(MemStream);
    Image.Picture.Assign(JPG);
  finally
    JPG.Free;
    MemStream.Free;
    HTTP.Free;
  end;
end;



procedure TfrmProcessGenerateUser.FormCreate(Sender: TObject);
begin
  cdsFavUser.FieldDefs.Clear;
  cdsFavUser.FieldDefs.Add('Name', ftString, 25);
  cdsFavUser.FieldDefs.Add('Username', ftString, 15);
  cdsFavUser.FieldDefs.Add('Email', ftString, 30);
  cdsFavUser.FieldDefs.Add('Phone', ftString, 20);
  cdsFavUser.FieldDefs.Add('Address', ftString, 30);
  cdsFavUser.CreateDataSet;
end;

end.
