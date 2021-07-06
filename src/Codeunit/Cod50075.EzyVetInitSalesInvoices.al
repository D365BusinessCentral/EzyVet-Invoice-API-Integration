codeunit 50075 "EzyVet Init Invoices"
{

    procedure InitInvoiceRecords()
    var
        lEzyVetLockDownDate: Record "EzyVet Lock Down Dates";
    begin

        EzyVetInvoiceHeader.Reset();
        if gInvoiceEntryNo <> 0 then
            EzyVetInvoiceHeader.SetRange(entry_no, gInvoiceEntryNo);
        EzyVetInvoiceHeader.SetRange(Processed, false);
        if EzyVetInvoiceHeader.FindFirst() then
            repeat
                if ValidateInvoices(EzyVetInvoiceHeader) then begin
                    EzyVetInsertSalesInvoice.CreateUpdateSalesHeader(EzyVetInvoiceHeader);
                    EzyVetInvoiceHeader.Processed := true;
                    EzyVetInvoiceHeader.Modify();
                end;
            until EzyVetInvoiceHeader.Next() = 0;

    end;

    procedure SetParameters(lInvoiceEntryNo: Integer)
    begin
        gInvoiceEntryNo := lInvoiceEntryNo;
    end;

    procedure ValidateInvoices(lEzyVetInvoiceHeader: Record "EzyVet Invoice Header") IsSuccess: Boolean
    var
        lCustomer: Record Customer;
        lEzyVetAPIIntegration: Record "EzyVet API Configuration";
    begin
        if lEzyVetInvoiceHeader.IsError then
            lEzyVetInvoiceHeader.IsError := false;
        if lEzyVetInvoiceHeader."Error Message" <> '' then
            lEzyVetInvoiceHeader."Error Message" := '';
        lEzyVetInvoiceHeader.Modify();

        if not lEzyVetAPIIntegration.Get() then begin
            lEzyVetInvoiceHeader.IsError := true;
            lEzyVetInvoiceHeader."Error Message" := 'EzyVet API Configuration is not setup';
            lEzyVetInvoiceHeader.Modify();
        end;
        if lEzyVetAPIIntegration."Dispense Account" = '' then begin
            lEzyVetInvoiceHeader.IsError := true;
            lEzyVetInvoiceHeader."Error Message" := 'Dispense Account is blank in EzyVet API Configuration setup';
            lEzyVetInvoiceHeader.Modify();
        end;
        if not lCustomer.get(lEzyVetInvoiceHeader.contact_id) then begin
            lEzyVetInvoiceHeader.IsError := true;
            lEzyVetInvoiceHeader."Error Message" := StrSubstNo('Customer %1 not found', lEzyVetInvoiceHeader.contact_id);
            lEzyVetInvoiceHeader.Modify();
        end;
        exit(true);

    end;


    var
        EzyVetInvoiceHeader: Record "EzyVet Invoice Header";
        EzyVetInvoiceLine: Record "EzyVet Invoice Line";
        EzyVetInsertSalesInvoice: Codeunit "EzyVet Update Sales Invoices";
        gInvoiceEntryNo: Integer;

}
