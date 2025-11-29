namespace Wanamics.PdfViewer;

using Microsoft.Purchases.Document;

pageextension 87180 "WanaPdf Purchase Invoice" extends "Purchase Invoice"
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
