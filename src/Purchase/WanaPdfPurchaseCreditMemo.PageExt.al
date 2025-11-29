namespace Wanamics.PdfViewer;

using Microsoft.Purchases.Document;

pageextension 87181 "WanaPdf Purchase Credit Memo" extends "Purchase Credit Memo"
{
    layout
    {
        addfirst(factboxes)
        {
            part(WanaPdfFactbox; "WanaPdf Factbox")
            {
                Caption = 'Pdf Document';
                ApplicationArea = All;
                SubPageLink = "Entry No." = field("Incoming Document Entry No.");
            }
        }
    }
}
