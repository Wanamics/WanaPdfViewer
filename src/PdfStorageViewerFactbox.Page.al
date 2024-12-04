namespace Wanamics.PdfViewer;

page 87173 "WanaPdf Storage Viewer Factbox"
{
    SourceTable = "PDFV2 PDF Storage";
    ApplicationArea = All;
    Caption = 'PDF document';
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
        PadAsText := Rec.WanaPdfGetAsText();
        CurrPage.PdfV2PdfViewer.LoadPDF(PadAsText, true);
    end;

    procedure SetRecord(pRecordID: RecordId)
    begin
        Rec.SetRange("Source Record ID", pRecordID);
        CurrPage.Update();
    end;
}
