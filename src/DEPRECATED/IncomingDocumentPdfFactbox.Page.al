#if FALSE
namespace Wanamics.PdfViewer;

using Microsoft.EServices.EDocument;
using System.Text;
using System.Utilities;

page 87172 "WanaPdf Factbox"
{
    SourceTable = "Incoming Document";
    ApplicationArea = All;
    PageType = CardPart;
    ShowFilter = false;
    Editable = false;

    layout
    {
        area(Content)
        {

            usercontrol(PDFViewer; "PDFV2 PDF Viewer")
            {
                trigger ControlAddinReady()
                begin
                    if PDFAsTxt <> '' then
                        CurrPage.PDFViewer.LoadPDF(PDFAsTxt, false);
                end;
            }
        }
    }

    var
        PDFAsTxt: Text;
        IsPdf: Boolean;

    trigger OnAfterGetRecord()
    var
        IncomingDocumentAttachment: Record "Incoming Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        PDFOutStream: OutStream;
        PDFInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        IncomingDocumentAttachment.SetRange("Incoming Document Entry No.", Rec."Entry No.");
        IncomingDocumentAttachment.SetRange("Main Attachment", true);
        IsPdf := IncomingDocumentAttachment.FindFirst or (IncomingDocumentAttachment.Type <> IncomingDocumentAttachment.Type::PDF);
        CurrPage.PDFViewer.SetVisible(IsPdf);
        if not IsPdf then
            exit;
        TempBlob.CreateOutStream(PDFOutStream, TextEncoding::UTF8);
        IncomingDocumentAttachment.CalcFields(Content);
        IncomingDocumentAttachment.Content.CreateInStream(PDFInStream, TextEncoding::UTF8);
        PDFAsTxt := Base64Convert.ToBase64(PDFInStream);

        // CurrPage.PDFViewer.LoadPDF(PDFAsTxt, false); //???????????
    end;
}
#endif