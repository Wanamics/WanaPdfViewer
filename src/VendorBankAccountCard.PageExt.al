namespace Wanamics.PdfViewer;

using Microsoft.Purchases.Vendor;
pageextension 87173 "WanaPdf Vendor Bank Acc. Card" extends "Vendor Bank Account Card"
{
    layout
    {
        movefirst(Communication; Contact)
        movefirst(Communication; Address)
        movefirst(Communication; "Address 2")
        movefirst(Communication; "Post Code")
        movefirst(Communication; City)
        movefirst(Communication; "Country/Region Code")
        movefirst(Communication; "Phone No.")
        // modify(Address) { Importance = Additional; }
        // modify("Address 2") { Importance = Additional; }
        // modify("Post Code") { Importance = Additional; }
        // modify(City) { Importance = Additional; }
        // modify("Country/Region Code") { Importance = Additional; }
        // modify("Phone No.") { Importance = Additional; }
        movelast(General; "SWIFT Code")
        movelast(General; IBAN)
        modify("Bank Branch No.") { Importance = Additional; }
        modify("Agency Code") { Importance = Additional; }
        modify("Bank Account No.") { Importance = Additional; }
        modify("RIB Key") { Importance = Additional; }
        modify("RIB Checked") { Importance = Additional; }
        addbefore(Transfer)
        {
            group(WanaPdfViewer)
            {
                ShowCaption = false;
                Visible = PdfAsText <> '';
                usercontrol(PdfV2PdfViewer; "PDFV2 PDF Viewer")
                {
                    ApplicationArea = All;
                }
            }
        }
        addlast(factboxes)
        {
            part(WanaPdfStorageFactbox; "WanaPdf Storage Factbox")
            {
                ApplicationArea = All;
                Visible = false;
            }
            part(WanaPdfStorageViewerFactbox; "WanaPdf Storage Viewer Factbox")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
    actions
    {
        addfirst(Processing)
        {
            action(WanaPdfUpload)
            {
                ApplicationArea = All;
                Image = Attach;
                Caption = 'Upload';
                ToolTip = 'Upload';
                Enabled = Rec.Code <> '';
                trigger OnAction()
                var
                    PDFStorage: Record "PDFV2 PDF Storage";
                    ReplaceLbl: Label 'Do you want to replace existing %1?';
                begin
                    PDFStorage.SetCurrentKey("Source Record ID");
                    PDFStorage.SetRange("Source Record ID", Rec.RecordId);
                    if not PDFStorage.IsEmpty then
                        if not Confirm(ReplaceLbl, false, PDFStorage.TableCaption) then
                            exit;
                    PDFStorage.DeleteAll(true);
                    PDFStorage.UploadContent(Rec.RecordId);
                    CurrPage.Update(true);
                end;
            }
        }
        addfirst(Promoted)
        {
            actionref(WanaPdfUpload_Promoted; WanaPdfUpload) { }
        }
    }
    trigger OnOpenPage()
    begin
        FactboxesSetRecord(false);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        FactboxesSetRecord(true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        FactboxesSetRecord(false);
    end;

    local procedure FactboxesSetRecord(pIsEditable: Boolean)
    begin
        CurrPage.WanaPdfStorageFactbox.Page.SetRecord(Rec.RecordId, pIsEditable);
        CurrPage.WanaPdfStorageViewerFactbox.Page.SetRecord(Rec.RecordId);
    end;

    trigger OnAfterGetCurrRecord()
    var
        PdfStorage: Record "PDFV2 PDF Storage";
    begin
        FactboxesSetRecord(Rec.WanaPdfIsEditable());
        PdfStorage.SetRange("Source Record ID", Rec.RecordId);
        if PdfStorage.FindFirst() then
            PdfAsText := PdfStorage.WanaPdfGetAsText()
        else
            PdfAsText := '';
        CurrPage.PdfV2PdfViewer.LoadPDF(PDFAsText, true);
    end;

    var
        PdfAsText: Text;
}
