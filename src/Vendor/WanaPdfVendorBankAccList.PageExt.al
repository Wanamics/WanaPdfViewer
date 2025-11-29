namespace Wanamics.PdfViewer;

using Microsoft.Purchases.Vendor;
pageextension 87172 "WanaPdf Vendor Bank Acc. List" extends "Vendor Bank Account List"
{
    layout
    {
        addlast(Control1)
        {
            field(WanaPdfStorageCount; WanaPdfStorageCount())
            {
                Caption = 'Pdf Storage Count';
                ApplicationArea = All;
                BlankZero = true;
                Visible = false;
            }
        }
        addlast(factboxes)
        {
            part(WanaPdfStorageFactbox; "WanaPdf Storage Factbox")
            {
                ApplicationArea = All;
            }
            part(WanaPdfStorageViewerFactbox; "WanaPdf Storage Viewer Factbox")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
    trigger OnOpenPage()
    begin
        FactboxesSetRecord(false, false);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        FactboxesSetRecord(true, true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        FactboxesSetRecord(false, false);
    end;

    local procedure FactboxesSetRecord(pSet: Boolean; pIsEditable: Boolean)
    var
        RecordId: RecordId;
    begin
        if pSet then
            RecordId := Rec.RecordId;
        CurrPage.WanaPdfStorageFactbox.Page.SetRecord(RecordId, pIsEditable);
        CurrPage.WanaPdfStorageViewerFactbox.Page.SetRecord(RecordId);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        FactboxesSetRecord(true, Rec.WanaPdfIsEditable());
    end;

    local procedure WanaPdfStorageCount(): Integer
    var
        PdfStorage: Record "PDFV2 PDF Storage";
    begin
        PdfStorage.SetCurrentKey("Source Record ID");
        PdfStorage.SetRange("Source Record ID", Rec.RecordId());
        exit(PdfStorage.Count());
    end;
}
