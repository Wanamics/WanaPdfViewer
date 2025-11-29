namespace Wanamics.PdfViewer;

using Microsoft.Bank.DirectDebit;
pageextension 87174 "WanaPdf SEPA DD Mandate" extends "SEPA Direct Debit Mandates"
{
    layout
    {
        addlast(Group)
        {
            field(WanaPdfStorageCount; WanaPdfStorageCount())
            {
                Caption = 'Pdf Storage Count';
                ApplicationArea = All;
                BlankZero = true;
                Visible = false;
            }
        }
        addlast(factboxes)
        {
            part(WanaPdfStorageFactbox; "WanaPdf Storage Factbox")
            {
                ApplicationArea = All;
            }
            part(WanaPdfStorageViewerFactbox; "WanaPdf Storage Viewer Factbox")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        PdfStorage: Record "PDFV2 PDF Storage";
    begin
        CurrPage.WanaPdfStorageFactbox.Page.SetRecord(Rec.RecordId(), Rec.WanaPdfIsEditable());
        CurrPage.WanaPdfStorageViewerFactbox.Page.SetRecord(Rec.RecordId());
    end;

    local procedure WanaPdfStorageCount(): Integer
    var
        PdfStorage: Record "PDFV2 PDF Storage";
    begin
        PdfStorage.SetCurrentKey("Source Record ID");
        PdfStorage.SetRange("Source Record ID", Rec.RecordId());
        exit(PdfStorage.Count());
    end;
}
