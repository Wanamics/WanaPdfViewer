// Credit https://www.hougaard.com/print-a-pdf-from-business-central-thats-easy-isnt-it/
namespace Wanamics.PdfViewer;

using System.Utilities;

report 87172 "Print PDF"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    DefaultLayout = Word;
    WordLayout = 'PrintPDF.docx';

    dataset
    {
        dataitem(Integer;Integer)
        {
            DataItemTableView = where(Number = const(17));
            column(Number; Number) { }
        }
    }
    trigger OnPreReport()
    var
        PrintPDF: Codeunit "Print PDF";
    begin
        // if UploadIntoStream('', InS) then
            PrintPDF.PDFToPrint(InS);
    end;

    var
        InS: InStream;
        procedure SetInStream(var pInStream : InStream)
        begin
            InS := pInStream;
        end;
}
