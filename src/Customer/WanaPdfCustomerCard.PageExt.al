namespace Wanamics.PdfViewer;

using Microsoft.Sales.Customer;

pageextension 87179 "WanaPdf Customer Card" extends "Customer Card"
{
    actions
    {
        modify("PDFV2 PDFStorage")
        {
            //[
            Visible = false;
            //]
        }
    }
}
