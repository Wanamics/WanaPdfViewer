namespace Wanamics.PdfViewer;

codeunit 87172 "WanaPdf WanApprove Decoupled"
{
    procedure IsEditable(var RecRef: RecordRef): Boolean
    var
        FldRef: FieldRef;
        ApprovalStatusField: Integer;
        ApprovalStatusValue: Integer;
    begin
        ApprovalStatusField := 87420;
        if not RecRef.FieldExist(ApprovalStatusField) then
            exit(true);
        FldRef := RecRef.Field(ApprovalStatusField);
        ApprovalStatusValue := FldRef.Value;
        exit(ApprovalStatusValue = 0);
    end;
}
