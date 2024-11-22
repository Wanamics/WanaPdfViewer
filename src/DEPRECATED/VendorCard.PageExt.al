#if FALSE
namespace Wanamics.PdfViewer;

using Microsoft.Purchases.Vendor;
pageextension 87178 "WanaPdf Vendor Card" extends "Vendor Card"
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
#endif
