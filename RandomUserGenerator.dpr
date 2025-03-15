program RandomUserGenerator;

uses
  Vcl.Forms,
  UFrmProcessGenerateUser in 'UFrmProcessGenerateUser.pas' {frmProcessGenerateUser},
  UFrmNavFavoriteUsers in 'UFrmNavFavoriteUsers.pas' {frmNavFavoriteUsers};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmProcessGenerateUser, frmProcessGenerateUser);
  Application.CreateForm(TfrmNavFavoriteUsers, frmNavFavoriteUsers);
  Application.Run;
end.
