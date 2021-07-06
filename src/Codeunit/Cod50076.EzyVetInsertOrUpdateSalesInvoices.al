codeunit 50076 "EzyVet Update Sales Invoices"
{
    procedure CreateUpdateSalesHeader(lEzyVetInvoiceHeader: Record "EzyVet Invoice Header")
    var
        lSalesHeader: Record "Sales Header";
        lCustomer: Record Customer;
    begin

        lSalesHeader.Reset;
        lSalesHeader.SetRange("Document Type", lSalesHeader."Document Type"::Invoice);
        lSalesHeader.SetRange("EzyVet Invoice ID", lEzyVetInvoiceHeader.id);
        if not lSalesHeader.FindFirst() then begin
            lCustomer.get(lEzyVetInvoiceHeader.contact_id);
            lSalesHeader.Init();
            lSalesHeader."Document Type" := lSalesHeader."Document Type"::Invoice;
            lSalesHeader.InitInsert();
            lSalesHeader.Validate("Sell-to Customer No.", lCustomer."No.");
            lSalesHeader.Insert();
        end;
        CopyFromEzyVetInvoiceHeader(lEzyVetInvoiceHeader, lSalesHeader);
        lSalesHeader.Modify();
        CreateUpdateSalesLine(lEzyVetInvoiceHeader, lSalesHeader);
        if GuiAllowed then
            Message('Invoice %1 created/modified for EzyVet Invoice', lSalesHeader."No.");
    end;

    local procedure CopyFromEzyVetInvoiceHeader(lEzyVetInvoiceHeader: Record "EzyVet Invoice Header"; var lSalesHeader: Record "Sales Header")
    var
        lDate: Integer;
        lDueDate: Integer;
        lPostingDateTime: DateTime;
        lDueDateTime: DateTime;
    begin
        if lEzyVetInvoiceHeader.date <> '' then begin
            Evaluate(lDate, lEzyVetInvoiceHeader.date);
            lPostingDateTime := gEpochConvertor.EpochDateTimeToSystemDateTime(lDate);
        end;

        if lEzyVetInvoiceHeader.due_date <> '' then begin
            Evaluate(lDueDate, lEzyVetInvoiceHeader.due_date);
            lDueDateTime := gEpochConvertor.EpochDateTimeToSystemDateTime(lDueDate);
        end;

        lSalesHeader.validate("Posting Date", DT2Date(lPostingDateTime));
        lSalesHeader.Validate("Document Date", DT2Date(lPostingDateTime));
        lSalesHeader.Validate("Due Date", DT2Date(lDueDateTime));
        lSalesHeader."EzyVet Code" := lEzyVetInvoiceHeader.code;
        lSalesHeader."EzyVet Contact ID" := lEzyVetInvoiceHeader.contact_id;
        lSalesHeader."EzyVet Invoice ID" := lEzyVetInvoiceHeader.id;
    end;

    local procedure CreateUpdateSalesLine(lEzyVetInvoiceHeader: Record "EzyVet Invoice Header"; var lSalesHeader: Record "Sales Header")
    var
        lSalesLine: Record "Sales Line";
        lEzyVetInvoiceLine: Record "EzyVet Invoice Line";
        lGenPostingSetup: Record "General Posting Setup";
        lItem: Record Item;
        lDispenseAmount: Decimal;
    begin
        Clear(gLineNo);
        lEzyVetInvoiceLine.Reset();
        lEzyVetInvoiceLine.SetRange("Header Entry No.", lEzyVetInvoiceHeader.entry_no);
        if lEzyVetInvoiceLine.FindFirst() then
            repeat
                Clear(lDispenseAmount);
                gLineNo += 10000;
                lSalesLine.Reset();
                lSalesLine.SetRange("Document Type", lSalesHeader."Document Type");
                lSalesLine.SetRange("Document No.", lSalesHeader."No.");
                lSalesLine.SetRange("EzyVet Invoice Line ID", lEzyVetInvoiceLine.id);
                if not lSalesLine.FindFirst() then begin
                    lSalesLine.init();
                    lSalesLine."Document Type" := lSalesHeader."Document Type";
                    lSalesLine."Document No." := lSalesHeader."No.";
                    lSalesLine."Line No." := gLineNo;
                    lSalesLine.Type := lSalesLine.Type::"G/L Account";
                    lSalesLine.Insert();
                end;
                lItem.Get(lEzyVetInvoiceLine.product_id);
                lGenPostingSetup.get(lSalesHeader."Gen. Bus. Posting Group", lItem."Gen. Prod. Posting Group");
                lSalesLine.Validate("No.", lGenPostingSetup."Sales Account");
                AssignSalesLine(lEzyVetInvoiceLine, lSalesLine);
                lSalesLine.Modify();

                if lEzyVetInvoiceLine.dispense <> '0' then begin
                    Evaluate(lDispenseAmount, lEzyVetInvoiceLine.dispense);
                    gLineNo += 10000;
                    CreateDispenseLine(gLineNo, lSalesLine, lSalesHeader, lDispenseAmount);
                end;
            until lEzyVetInvoiceLine.Next() = 0;

    end;

    local procedure AssignSalesLine(lEzyVetInvoiceLine: Record "EzyVet Invoice Line"; Var lSalesLine: Record "Sales Line")
    var
        lPrice: Decimal;
        lLineDiscount: Decimal;
    begin
        Clear(lPrice);
        lSalesLine.Description := CopyStr(lEzyVetInvoiceLine.name, 1, 100);
        lSalesLine.Validate(Quantity, 1);
        Evaluate(lPrice, lEzyVetInvoiceLine.price);
        Evaluate(lLineDiscount, lEzyVetInvoiceLine.discount);
        lSalesLine.Validate("Unit Price", lPrice);
        if lLineDiscount <> 0 then
            lSalesLine.Validate("Line Discount Amount", lLineDiscount);
    end;

    local procedure CreateDispenseLine(lLineNo: Integer; lSalesLine: record "Sales Line"; lSalesHeader: record "Sales Header"; lDispenseAmount: Decimal)
    var
        lAPIConfiguration: Record "EzyVet API Configuration";
    begin
        lAPIConfiguration.Get();
        lSalesLine.Reset();
        lSalesLine.SetRange("Document Type", lSalesHeader."Document Type");
        lSalesLine.SetRange("Document No.", lSalesHeader."No.");
        lSalesLine.SetRange(Type, lSalesLine.Type::"G/L Account");
        lSalesLine.SetRange("No.", lAPIConfiguration."Dispense Account");
        if not lSalesLine.FindFirst() then begin
            lSalesLine.init();
            lSalesLine."Document Type" := lSalesHeader."Document Type";
            lSalesLine."Document No." := lSalesHeader."No.";
            lSalesLine."Line No." := lLineNo;
            lSalesLine.Type := lSalesLine.Type::"G/L Account";
            lSalesLine.validate("No.", lAPIConfiguration."Dispense Account");
            lSalesLine.Insert();
        end;
        lSalesLine.Validate(Quantity, 1);
        lSalesLine.Validate("Unit Price", lDispenseAmount);
        lSalesLine.Modify();
    end;

    var
        gEpochConvertor: Codeunit "EzyVet Epoch Convertor";
        gLineNo: Integer;

}
