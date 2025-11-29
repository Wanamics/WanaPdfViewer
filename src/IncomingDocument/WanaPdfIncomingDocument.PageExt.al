namespace Wanamics.PdfViewer;

using Microsoft.EServices.EDocument;

pageextension 87177 "WanaPdf Incoming Document" extends "Incoming Document"
{
    layout
    {
        addafter(FinancialInformation)
        {
            group(WanaPdfViewer)
            {
                ShowCaption = false;
                Visible = PadAsText <> '';
                usercontrol(PdfV2PdfViewer; "PDFV2 PDF Viewer")
                {
                    ApplicationArea = All;
                }
            }
        }
        addlast(factboxes)
        {
            part(WanaPdfFactbox; "WanaPdf Factbox")
            {
                Caption = 'Pdf Document';
                Visible = false;
                ApplicationArea = All;
                SubPageLink = "Entry No." = field("Entry No.");
            }
        }
    }

    var
        PadAsText: Text;

    trigger OnAfterGetCurrRecord()
    begin
        PadAsText := Rec.WanaPdfGetMainAttachmentAsText();
        CurrPage.PdfV2PdfViewer.LoadPDF(PadAsText, true);
    end;
}
