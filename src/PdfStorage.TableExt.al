namespace Wanamics.PdfViewer;

using System.Text;
using System.Utilities;

tableextension 87175 "WanaPdf Storage" extends "PDFV2 PDF Storage"
{
    keys
    {
        key(SourceRecordId; "Source Record ID")
        {
        }
    }
    trigger OnInsert()
    begin
        Rec.TestField("Source Record ID");
    end;

    procedure WanaPdfGetAsText(): Text
    var
        TempBlob: Codeunit "Temp Blob";
        PDFInStream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin
        if not Rec."PDF Value".HasValue() then
            exit;
        CalcFields("PDF Value");
        "PDF Value".CreateInStream(PDFInStream, TextEncoding::UTF8);
        exit(Base64Convert.ToBase64(PDFInStream));
    end;

}
