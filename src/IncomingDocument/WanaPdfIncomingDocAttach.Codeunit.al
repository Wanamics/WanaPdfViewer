namespace Wanamics.PdfViewer;

using Microsoft.EServices.EDocument;
using System.Utilities;

codeunit 87177 "WanaPdf Incoming Doc. Attach."
{
    TableNo = "Incoming Document Attachment";
    trigger OnRun()
    var
        TempBlob: Codeunit "Temp Blob";
        PDFViewer: Page "PDFV2 PDF Viewer";
        PDFOutStream: OutStream;
        PDFInStream: InStream;
    begin
        TempBlob.CreateOutStream(PDFOutStream, TextEncoding::UTF8);
        Rec.CalcFields(Content);
        Rec.Content.CreateInStream(PDFInStream, TextEncoding::UTF8);
        PDFViewer.SetPDFDocument(PDFInStream);
        PDFViewer.Run();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Inc. Doc. Attachment Overview", OnBeforeNameDrillDown, '', false, false)]
    local procedure OnBeforeNameDrillDown(var IncDocAttachmentOverview: Record "Inc. Doc. Attachment Overview"; var IsHandled: Boolean)
    var
        IncomingDocumentAttachment: Record "Incoming Document Attachment";
    begin
        case IncDocAttachmentOverview."Attachment Type" of
            IncDocAttachmentOverview."Attachment Type"::"Main Attachment",
            IncDocAttachmentOverview."Attachment Type"::"Supporting Attachment":
                if IncomingDocumentAttachment.Get(IncDocAttachmentOverview."Incoming Document Entry No.", IncDocAttachmentOverview."Line No.") and
                    (IncomingDocumentAttachment."File Extension".ToLower() = 'pdf') then
                    IsHandled := Codeunit.Run(Codeunit::"WanaPdf Incoming Doc. Attach.", IncomingDocumentAttachment);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Incoming Document Attachment", OnBeforeExport, '', false, false)]
    local procedure OnBeforeExport(var IncomingDocumentAttachment: Record "Incoming Document Attachment")
    var
        TempBlob: Codeunit "Temp Blob";
    begin
        if not IncomingDocumentAttachment.GetContent(TempBlob) then
            exit;

        if IncomingDocumentAttachment."File Extension".ToLower() = 'pdf' then
            if Codeunit.Run(Codeunit::"WanaPdf Incoming Doc. Attach.", IncomingDocumentAttachment) then
                error('');
    end;
}
