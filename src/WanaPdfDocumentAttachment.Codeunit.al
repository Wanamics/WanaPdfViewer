namespace Wanamics.PdfViewer;

using System.Utilities;
using Microsoft.Foundation.Attachment;

codeunit 87179 "WanaPdf Document Attachment"
{
    TableNo = "Document Attachment";
    trigger OnRun()
    var
        TempBlob: Codeunit "Temp Blob";
        PDFViewer: Page "PDFV2 PDF Viewer";
        PDFOutStream: OutStream;
        PDFInStream: InStream;
    begin
        TempBlob.CreateOutStream(PDFOutStream, TextEncoding::UTF8);
        Rec.GetAsTempBlob(TempBlob);
        TempBlob.CreateInStream(PDFInStream, TextEncoding::UTF8);
        PDFViewer.SetPDFDocument(PDFInStream);
        PDFViewer.Run();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", OnBeforeExportAttachment, '', false, false)]
    local procedure OnBeforeExportAttachment(var DocumentAttachment: Record "Document Attachment")
    var
        TempBlob: Codeunit "Temp Blob";
    begin
        if not DocumentAttachment.HasContent() then
            exit;
        DocumentAttachment.GetAsTempBlob(TempBlob);
        if DocumentAttachment."File Type" = DocumentAttachment."File Type"::PDF then
            if Codeunit.Run(Codeunit::"WanaPdf Document Attachment", DocumentAttachment) then
                error('');
    end;
}