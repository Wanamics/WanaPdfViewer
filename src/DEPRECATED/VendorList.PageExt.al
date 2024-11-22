#if FALSE
namespace Wanamics.PdfViewer;

using Microsoft.Purchases.Vendor;
pageextension 87171 "WanaPdf Vendor List" extends "Vendor List"
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
        CurrPage.WanaPdfStorageFactbox.Page.SetFilterOnRecord(Rec.RecordId());
    end;
}
#endif
