namespace Wanamics.PdfViewer;

using Microsoft.Sales.Customer;
pageextension 87176 "WanaPdf Cust. Bank Acc. List" extends "Customer Bank Account List"
{
    layout
    {
        addlast(Control1)
        {
            field(WanaPdfStorageCount; WanaPdfStorageCount())
            {
                Caption = 'Pdf Storage Count';
                ApplicationArea = All;
                BlankZero = true;
                //[
                Visible = false;
                //]
            }
        }
        addlast(factboxes)
        {
            part(WanaPdfStorageFactbox; "WanaPdf Storage Factbox")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.WanaPdfStorageFactbox.Page.SetRecord(Rec.RecordId(), true);
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
