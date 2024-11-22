namespace Wanamics.PdfViewer;

using Microsoft.Purchases.Vendor;
pageextension 87173 "WanaPdf Vendor Bank Acc. Card" extends "Vendor Bank Account Card"
{
    layout
    {
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
        CurrPage.WanaPdfStorageFactbox.PAGE.SetFilterOnRecord(Rec.RecordId());
    end;
}
