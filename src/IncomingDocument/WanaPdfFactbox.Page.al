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
            group(General)
            {
                ShowCaption = false;
                Visible = PadAsText <> '';

                usercontrol(PdfV2PdfViewer; "PDFV2 PDF Viewer")
                {
                }
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
