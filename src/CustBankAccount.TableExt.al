namespace Wanamics.PdfViewer;

using Microsoft.Sales.Customer;
tableextension 87172 "WanaPdf Cust. Bank Account" extends "Customer Bank Account"
{
    trigger OnAfterDelete()
    var
        PDFStorage: Record "PDFV2 PDF Storage";
    begin
        PDFStorage.SetCurrentKey("Source Record ID");
        PDFStorage.SetRange("Source Record ID", RecordId);
        PDFStorage.DeleteAll(true);
    end;
}
