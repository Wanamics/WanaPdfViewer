namespace Wanamics.PdfViewer;

using Microsoft.Sales.Customer;
pageextension 87175 "WanaPdf Cust. Bank Acc. Card" extends "Customer Bank Account Card"
{
    layout
    {
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
        CurrPage.WanaPdfStorageFactbox.PAGE.SetRecord(Rec.RecordId(), true);
    end;
}
