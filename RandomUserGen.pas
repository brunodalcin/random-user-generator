unit RandomUserGen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, Vcl.ExtCtrls, Vcl.StdCtrls,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, Vcl.Imaging.jpeg,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TfrmProcessGenerateProfile = class(TForm)
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
    procedure btnNewProfileClick(Sender: TObject);
  private
    { Private declarations }
    procedure DownloadImg(URL: string) ;
  public
    { Public declarations }
  end;

var
  frmProcessGenerateProfile: TfrmProcessGenerateProfile;

implementation

{$R *.dfm}

procedure TfrmProcessGenerateProfile.btnNewProfileClick(Sender: TObject);
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

      // Pegando os valores do JSON
      lbName.Caption := JSONObject.GetValue<TJSONObject>('name').GetValue<string>('first') + ' ' +
                           JSONObject.GetValue<TJSONObject>('name').GetValue<string>('last');
      lbUsername.Caption := JSONObject.GetValue<TJSONObject>('login').GetValue<string>('username');
      lbEmail.Caption := JSONObject.GetValue<string>('email');
      lbPhone.Caption := JSONObject.GetValue<string>('phone');
      lbAddress.Caption := JSONObject.GetValue<TJSONObject>('location').GetValue<string>('city') + ', ' +
                                  JSONObject.GetValue<TJSONObject>('location').GetValue<string>('country');

      // Carregando imagem do usuário
      //Image.Picture.LoadFromFile(JSONObject.GetValue<TJSONObject>('picture').GetValue<string>('large'));
      DownloadImg(JSONObject.GetValue<TJSONObject>('picture').GetValue<string>('large'));

    end;
  end;

end;

procedure TfrmProcessGenerateProfile.DownloadImg(URL: string);
var
  HTTP: TNetHTTPClient;
  MemStream: TMemoryStream;
  JPG: TJPEGImage;
begin
  HTTP := TNetHTTPClient.Create(nil);
  MemStream := TMemoryStream.Create;
  JPG := TJPEGImage.Create;
  try
    // Faz o download da imagem e armazena em MemStream
    HTTP.Get(URL, MemStream);
    MemStream.Position := 0; // Reseta a posição do stream

    // Carrega a imagem no formato JPEG
    JPG.LoadFromStream(MemStream);
    Image.Picture.Assign(JPG); // Exibe no TImage
  finally
    JPG.Free;
    MemStream.Free;
    HTTP.Free;
  end;
end;



end.
