program Discord4D;

uses
  System.StartUpCopy,
  FMX.Forms,
  UntMaster in 'UntMaster.pas' {FrmMaster},
  UntDM in 'UntDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMaster, FrmMaster);
  Application.Run;
end.
