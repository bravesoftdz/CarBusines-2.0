unit UnitRelDepartments;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UnitPatternRel, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.StdCtrls, Vcl.ExtCtrls, frxExportXLSX, frxExportDOCX, frxClass,
  frxExportPDF, frxDBSet, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin;

type
  TFrmRelDepartments = class(TFrmPatternRel)
    NomeDe: TLabeledEdit;
    NomeAte: TLabeledEdit;
    edtCodigoDe: TLabeledEdit;
    edtCodigoAte: TLabeledEdit;
    RadioGroup1: TRadioGroup;
    procedure btnprintClick(Sender: TObject);
    procedure btncancelrelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelDepartments: TFrmRelDepartments;

implementation

{$R *.dfm}

procedure TFrmRelDepartments.btncancelrelClick(Sender: TObject);
begin
  inherited;
    edtCodigoDe.Clear;
    edtCodigoAte.Clear;
    NomeDe.Clear;
    NomeAte.Clear;
    Close;
end;

procedure TFrmRelDepartments.btnprintClick(Sender: TObject);
Var StrLiga : String;
begin
  inherited;
    StrLiga := 'where ';
    FDQuery1.Close;
    with FDQuery1.SQL do
    begin
      Clear;
      Add('select * from departments ');
      if edtCodigoDe.Text <> '' then
      try
        StrToInt(edtCodigoDe.Text);
        Add(StrLiga+ 'id >= '+ edtCodigoDe.Text);
        StrLiga := 'and ';
      except
        on EConvertError do
        ;
      end;
      if edtCodigoAte.Text <> '' then
      try
        StrToInt(edtCodigoAte.Text);
        Add(StrLiga+ 'id <= '+ edtCodigoAte.Text);
        StrLiga := 'and ';
      except
        on EConvertError do
        ;
      end;
        if NomeDe.Text <> '' then
        begin
          Add(StrLiga+'department >= '''+NomeDe.Text+'''');
          StrLiga := 'and ';
        end;
          if NomeAte.Text <> '' then
          Add(StrLiga+'department <= '''+NomeAte.Text+'zzz''');
          case RadioGroup1.ItemIndex of
            0 : Add('order by id');
            1 : Add('order by department');
          end;
    end;
    FDQuery1.Open;
    frxReport1.ShowReport();
    edtCodigoDe.Clear;
    edtCodigoAte.Clear;
    NomeDe.Clear;
    NomeAte.Clear;
end;
end.
