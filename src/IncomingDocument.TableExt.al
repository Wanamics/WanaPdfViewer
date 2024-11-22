namespace Wanamics.PdfViewer;

using Microsoft.EServices.EDocument;
using System.Text;
using System.Utilities;

tableextension 87174 "WanaPdf Incoming Document" extends "Incoming Document"
{
    procedure WanaPdfGetMainAttachmentAsText(): Text
    var
        IncomingDocumentAttachment: Record "Incoming Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        PDFOutStream: OutStream;
        PDFInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        IncomingDocumentAttachment.SetRange("Incoming Document Entry No.", "Entry No.");
        IncomingDocumentAttachment.SetRange("Main Attachment", true);
        if not IncomingDocumentAttachment.FindFirst and (IncomingDocumentAttachment.Type = IncomingDocumentAttachment.Type::PDF) then
            exit('');
        TempBlob.CreateOutStream(PDFOutStream, TextEncoding::UTF8);
        IncomingDocumentAttachment.CalcFields(Content);
        IncomingDocumentAttachment.Content.CreateInStream(PDFInStream, TextEncoding::UTF8);
        exit(Base64Convert.ToBase64(PDFInStream));
    end;
}