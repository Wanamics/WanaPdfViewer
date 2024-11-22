#if FALSE
Moved to WanaPort
namespace Wanamics.PdfViewer;

using Microsoft.EServices.EDocument;
pageextension 87177 "WanaPdf Incoming Documents" extends "Incoming Documents"
{
    actions
    {
        addlast(Process)
        {
            action(WanaPdfImportZipFile)
            {
                Caption = 'Import Zip File';
                ApplicationArea = All;
                Image = Import;
                ToolTip = 'Import from Zip';

                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"WanaPdf Incoming Doc. From Zip", Rec);
                end;
            }
        }
        addafter(RemoveReferencedRecord)
        {
            action(WanaPdfDeleteSelection)
            {
                Caption = 'Delete Selection';
                ApplicationArea = All;
                Image = Delete;
                // Visible = false; 
                trigger OnAction()
                var
                    lRec: Record "Incoming Document";
                    ConfirmMsg: Label 'Do-you want to delete %1 "%2"?';
                begin
                    CurrPage.SetSelectionFilter(lRec);
                    if Confirm(ConfirmMsg, false, lRec.Count, lRec.TableCaption) then
                        lRec.DeleteAll(true);
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref(WanaPdfImportZipFile_Promoted; WanaPdfImportZipFile) { }
        }
    }
}
#endif