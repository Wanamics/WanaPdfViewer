namespace Wanamics.PdfViewer;

using Microsoft.EServices.EDocument;

pageextension 87177 "WanaPdf Incoming Document" extends "Incoming Document"
{
    layout
    {
        addafter(FinancialInformation)
        {
            // group(WanaPdfViewer)
            // {
            //     ShowCaption = false;
            //     Editable = false;
            usercontrol(PdfV2PdfViewer; "PDFV2 PDF Viewer")
            {
                ApplicationArea = All;
            }
            // }
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
        PDFAsTxt: Text;

    trigger OnAfterGetCurrRecord()
    begin
        PdfAsTxt := Rec.WanaPdfGetMainAttachmentAsText();
        CurrPage.PdfV2PdfViewer.LoadPDF(PDFAsTxt, true); //???????????
    end;
}
