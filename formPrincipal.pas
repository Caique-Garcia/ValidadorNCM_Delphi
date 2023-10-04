unit formPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.WinXCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, ACBrBase, ACBrSocket, ACBrNCMs,
  Datasnap.DBClient;

type
  TuFormPrincipal = class(TForm)
    PanelContainer: TPanel;
    PanelHeader: TPanel;
    PanelCorpo: TPanel;
    PanelBuscas: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    btnValidar: TButton;
    EditNCM: TEdit;
    EditNome: TSearchBox;
    LabelRes: TLabel;
    PanelGrid: TPanel;
    DBGrid1: TDBGrid;
    ACBrNCMs1: TACBrNCMs;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1CODNCM: TStringField;
    ClientDataSet1DESCRICAO: TStringField;
    ClientDataSet1DATAINICIO: TDateField;
    ClientDataSet1DATAFIM: TDateField;
    ClientDataSet1TIPOATO: TStringField;
    ClientDataSet1NUMEROATO: TStringField;
    ClientDataSet1ANOATO: TIntegerField;
    DataSource1: TDataSource;
    procedure btnValidarClick(Sender: TObject);
    procedure EditNomeInvokeSearch(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    procedure Atualizar(aListaNCM: TACBrNCMsList);
  public
    { Public declarations }
  end;

var
  uFormPrincipal: TuFormPrincipal;

implementation

{$R *.dfm}

procedure TuFormPrincipal.Atualizar(aListaNCM: TACBrNCMsList);
var
  I: Integer;
begin
  DBGrid1.Visible := False;
  try
    ClientDataSet1.Close;
    ClientDataSet1.CreateDataSet;

    for I := 0 to aListaNCM.Count - 1 do
    begin
      ClientDataSet1.Append;

      ClientDataSet1CODNCM.AsString := aListaNCM[I].CodigoNcm;
      ClientDataSet1DESCRICAO.AsString := aListaNCM[I].DescricaoNcm;
      ClientDataSet1DATAINICIO.Value := aListaNCM[I].DataInicio;
      ClientDataSet1DATAFIM.Value := aListaNCM[I].DataFim;
      //ClientDataSet1TIPOATO.Value := aListaNCM[I].TipoAto;
      //ClientDataSet1NUMEROATO.Value := aListaNCM[I].NumeroAto;
      //ClientDataSet1ANOATO.Value := aListaNCM[I].AnoAto;

      ClientDataSet1.Post;
    end;

    ClientDataSet1.First;
  finally
    DBGrid1.Visible := True;
  end;
end;

procedure TuFormPrincipal.btnValidarClick(Sender: TObject);
begin
    LabelRes.Caption := '';
    if not ACBrNcms1.Validar(EditNCM.Text) then
    begin
       LabelRes.Caption := 'NCM Inválido!';
       LabelRes.Font.Color := $001B08AD;
    end
    else
    begin
       LabelRes.Caption := 'NCM Valido!';
       LabelRes.Font.Color := $0095CF3B;
    end;
end;

procedure TuFormPrincipal.DBGrid1DblClick(Sender: TObject);
begin
    //
    EditNCM.Text:= ClientDataSet1CODNCM.AsString;
end;

procedure TuFormPrincipal.EditNomeInvokeSearch(Sender: TObject);
begin
  if EditNome.Text = '' then
  begin
    Atualizar(ACBrNcms1.NCMs);
    Exit;
  end;

  //ACBrNcms1.BuscarPorDescricao(EditNome.Text, ntfIniciaCom);
  ACBrNcms1.BuscarPorDescricao(EditNome.Text, ntfContem);
  //ACBrNcms1.BuscarPorDescricao(EditNome.Text, ntfFinalizaCom);

  Atualizar(ACBrNcms1.NCMsFiltrados);
end;

end.
