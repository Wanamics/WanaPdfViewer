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
            }
        }
        addlast(factboxes)
        {
            part(WanaPdfStorageFactbox; "WanaPdf PDF Storage Factbox")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.WanaPdfStorageFactbox.Page.SetFilterOnRecord(Rec.RecordId());
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
