permissionset 87171 "WANAPDF_VIEWER"
{
    Assignable = true;
    Caption = 'WanaPdf Viewer'; //, MaxLength = 30;
    IncludedPermissionSets = "PDFV2 PDF Viewer";
    Permissions =
        codeunit "WanaPdf Incoming Doc. Attach." = X,
        // codeunit "WanaPdf Incoming Doc. From Zip" = X,
        page "WanaPdf Storage Factbox" = X;
}