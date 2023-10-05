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
    ClientDataSet2: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    DateField1: TDateField;
    DateField2: TDateField;
    StringField3: TStringField;
    StringField4: TStringField;
    IntegerField1: TIntegerField;
    Button1: TButton;
    procedure btnValidarClick(Sender: TObject);
    procedure EditNomeInvokeSearch(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Atualizar(aListaNCM: TACBrNCMsList);
    procedure AtualizarDoArquivo(ANome: String; ADataSet: TClientDataSet);
    function ContemPalavra(const Texto, Palavra: string): Boolean;

  public
    { Public declarations }
  end;

var
  uFormPrincipal: TuFormPrincipal;

implementation
uses
    DataSet.Serialize, System.JSON;

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
      //ClientDataSet1DATAINICIO.Value := aListaNCM[I].DataInicio;
      //ClientDataSet1DATAFIM.Value := aListaNCM[I].DataFim;
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

procedure TuFormPrincipal.AtualizarDoArquivo(ANome: String; ADataSet: TClientDataSet);
Var
    LJSONObject: TJSONObject;
    LJSONArray: TJSONArray;
    PastaLocal, vConteudo: string;
    Arquivo: TStringList;
    vNomenclaturas: String;
    I: Integer;

begin
    //
    PastaLocal := ExtractFilePath(ParamStr(0));


    Arquivo := TStringList.Create;
    LJSONArray:= TJSONArray.Create;
    ClientDataSet1.Close;
    ClientDataSet1.CreateDataSet;

    Arquivo.LoadFromFile(PastaLocal + 'ACBrNCM.json');
    vConteudo := Arquivo.Text;
    //LJSONObject:= ClientDataSet2.LoadFromJSON();

    LJSONObject := TJSONObject.ParseJSONValue(vConteudo) as TJSONObject;
    vNomenclaturas:= LJSONObject.GetValue('Nomenclaturas').ToString;

    //Recebendo um Par do JSON que é um array de JSON e passando para um TJSONArray
    LJSONArray:= LJSONObject.GetValue('Nomenclaturas') as TJSONArray;

    //LJSONArray.Add(LJSONObject.GetValue('Nomenclaturas'));



    //Percorrendo o array de JSON
    for I := 0 to LJSONArray.Count - 1 do
    begin
      LJSONObject := TJSONObject.ParseJSONValue(LJSONArray.Items[I].ToString) as TJSONObject;

      if ContemPalavra(LJSONObject.GetValue('Descricao').Value, ANome) then
      begin
        ClientDataSet1.Append;
        ClientDataSet1CODNCM.AsString := LJSONObject.GetValue('Codigo').Value;
        ClientDataSet1DESCRICAO.AsString := LJSONObject.GetValue('Descricao').Value;
        ClientDataSet1.Post;
      end;
    end;


//Memo1.Lines.Add(intToStr(LJSONArray.Count -1));
    {
            "Codigo": "01",
			"Descricao": "Animais vivos.",
			"Data_Inicio": "01/04/2022",
			"Data_Fim": "31/12/9999",
			"Tipo_Ato": "Res Camex",
			"Numero_Ato": "272",
			"Ano_Ato": "2021"
	}
    //ClientDataSet1.First;
    LJSONArray.Free;
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

procedure TuFormPrincipal.Button1Click(Sender: TObject);
begin
   AtualizarDoArquivo(EditNome.Text, ClientDataSet1);
end;

function TuFormPrincipal.ContemPalavra(const Texto, Palavra: string): Boolean;
begin
  // Verifica se a posição da palavra na string é maior que zero
  Result := Pos(Palavra, Texto) > 0;
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
      try
         Atualizar(ACBrNcms1.NCMs);
      except
         AtualizarDoArquivo(EditNome.Text, ClientDataSet1);
      end;
    Exit;
  end;

  //ACBrNcms1.BuscarPorDescricao(EditNome.Text, ntfIniciaCom);
  //ACBrNcms1.BuscarPorDescricao(EditNome.Text, ntfFinalizaCom);
  try
      ACBrNcms1.BuscarPorDescricao(EditNome.Text, ntfContem);
  except
  end;

  try
     Atualizar(ACBrNcms1.NCMsFiltrados);
  except
     AtualizarDoArquivo(EditNome.Text, ClientDataSet1);
  end;


end;

end.
