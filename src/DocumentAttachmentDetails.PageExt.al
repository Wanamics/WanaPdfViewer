pageextension 87170 "WanaPdf Document Attachment D." extends "Document Attachment Details" //1173
{
    actions
    {
        modify("PDFV2 View PDF")
        {
            Enabled = Rec."File Type" = Rec."File Type"::Pdf;
        }
        // addfirst(processing)
        // {
        // }
        // //[
        // addfirst(Category_Process)
        // {
        //     actionref("PDFV2 View PDF Promoted"; "PDFV2 View PDF") { }
        // }
        // //]
    }
}
