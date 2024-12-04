namespace Wanamics.PdfViewer;

using Microsoft.Bank.DirectDebit;
tableextension 87171 "WanaPdf SEPA DD Mandate" extends "SEPA Direct Debit Mandate"
{
    trigger OnAfterDelete()
    var
        PDFStorage: Record "PDFV2 PDF Storage";
    begin
        PDFStorage.SetCurrentKey("Source Record ID");
        PDFStorage.SetRange("Source Record ID", RecordId);
        PDFStorage.DeleteAll(true);
    end;

    procedure WanaPdfIsEditable(): Boolean // Avoid Approval Dependency
    var
        RecRef: RecordRef;
        WanApproveDecoupled: Codeunit "WanaPdf WanApprove Decoupled";
    begin
        RecRef.GetTable(Rec);
        exit(WanApproveDecoupled.IsEditable(RecRef));
    end;
}
