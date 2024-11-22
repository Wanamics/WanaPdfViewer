namespace Wanamics.PdfViewer;

using Microsoft.EServices.EDocument;

page 87172 "WanaPdf Factbox"
{
    SourceTable = "Incoming Document";
    ApplicationArea = All;
    PageType = CardPart;
    Editable = false;

    layout
    {
        area(Content)
        {
            usercontrol(PdfV2PdfViewer; "PDFV2 PDF Viewer")
            {
            }
        }
    }

    var
        PDFAsTxt: Text;

    trigger OnAfterGetCurrRecord()
    begin
        PdfAsTxt := Rec.WanaPdfGetMainAttachmentAsText();
        CurrPage.PdfV2PdfViewer.LoadPDF(PDFAsTxt, true);
    end;
}
