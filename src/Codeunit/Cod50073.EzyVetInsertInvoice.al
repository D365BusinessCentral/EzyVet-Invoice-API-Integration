codeunit 50073 "EzyVet Insert Invoices"
{
    procedure InsertInvoices(lJSONText: Text; lRecordType: Option New,Modified; var lCount: Integer)
    var
        lEzyVetInvoiceHeader: Record "EzyVet Invoice Header";
        lEzyVetInvoiceLine: Record "EzyVet Invoice Line";
        lJSONObject: JsonObject;
        lJSONToken: JsonToken;
        lJSONArray: JsonArray;
        lJSONArray1: JsonArray;
        i: Integer;
        j: Integer;
        k: Integer;
        l: Integer;
        lHeaderEntryNo: Integer;
        lLineEntryNo: Integer;

    begin
        j := 0;
        lCount := 0;
        lEzyVetInvoiceHeader.Reset();
        if not lEzyVetInvoiceHeader.findlast() then
            lHeaderEntryNo := 0
        else
            lHeaderEntryNo := lEzyVetInvoiceHeader.entry_no;


        lJSONToken.ReadFrom(lJSONText);
        lJSONObject := lJSONToken.AsObject();
        lJSONToken.SelectToken('items', lJSONToken);
        lJSONArray := lJSONToken.AsArray();
        //Process JSON response
        for i := 0 to lJSONArray.Count - 1 do begin
            j += 1;
            lCount += 1;
            lJSONArray.Get(i, lJSONToken);
            lJSONToken.SelectToken('invoice', lJSONToken);
            lJSONObject := lJSONToken.AsObject();
            lEzyVetInvoiceHeader.Init();
            lEzyVetInvoiceHeader.entry_no := lHeaderEntryNo + j;
            lEzyVetInvoiceHeader.Insert();
            lEzyVetInvoiceHeader.id := GetJSONToken(lJSONObject, 'id').AsValue().AsText();
            lEzyVetInvoiceHeader.active := GetJSONToken(lJSONObject, 'active').AsValue().AsText();
            lEzyVetInvoiceHeader.created_at := GetJSONToken(lJSONObject, 'created_at').AsValue().AsText();
            lEzyVetInvoiceHeader.modified_at := GetJSONToken(lJSONObject, 'modified_at').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'code').AsValue().IsNull then
                lEzyVetInvoiceHeader.code := GetJSONToken(lJSONObject, 'code').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'animal_id').AsValue().IsNull then
                lEzyVetInvoiceHeader.animal_id := GetJSONToken(lJSONObject, 'animal_id').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'consult_id').AsValue().IsNull then
                lEzyVetInvoiceHeader.consult_id := GetJSONToken(lJSONObject, 'consult_id').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'contact_id').AsValue().IsNull then
                lEzyVetInvoiceHeader.contact_id := GetJSONToken(lJSONObject, 'contact_id').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'customer_reference_number').AsValue().IsNull then
                lEzyVetInvoiceHeader.customer_reference_number := GetJSONToken(lJSONObject, 'customer_reference_number').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'date').AsValue().IsNull then
                lEzyVetInvoiceHeader.date := GetJSONToken(lJSONObject, 'date').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'date_due').AsValue().IsNull then
                lEzyVetInvoiceHeader.due_date := GetJSONToken(lJSONObject, 'date_due').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'includes_tax').AsValue().IsNull then
                lEzyVetInvoiceHeader.includes_tax := GetJSONToken(lJSONObject, 'includes_tax').AsValue().AsText();
            //if not GetJSONToken(lJSONObject, 'limit').AsValue().IsNull then
            //lEzyVetInvoiceHeader.limit := GetJSONToken(lJSONObject, 'limit').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'ownership_id').AsValue().IsNull then
                lEzyVetInvoiceHeader.ownership_id := GetJSONToken(lJSONObject, 'ownership_id').AsValue().AsText();
            //if not GetJSONToken(lJSONObject, 'page').AsValue().IsNull then
            //lEzyVetInvoiceHeader.page := GetJSONToken(lJSONObject, 'page').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'payment_terms_id').AsValue().IsNull then
                lEzyVetInvoiceHeader.payment_terms_id := GetJSONToken(lJSONObject, 'payment_terms_id').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'subtotal').AsValue().IsNull then
                lEzyVetInvoiceHeader.subtotal := GetJSONToken(lJSONObject, 'subtotal').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'tax').AsValue().IsNull then
                lEzyVetInvoiceHeader.tax := GetJSONToken(lJSONObject, 'tax').AsValue().AsText();
            lEzyVetInvoiceHeader.created_at_date := EPOCHConvertor.EpochDateTimeToSystemDateTime(GetJSONToken(lJSONObject, 'created_at').AsValue().AsInteger());
            lEzyVetInvoiceHeader.modified_at_date := EPOCHConvertor.EpochDateTimeToSystemDateTime(GetJSONToken(lJSONObject, 'modified_at').AsValue().AsInteger());
            lEzyVetInvoiceHeader.Modify();

            Clear(k);
            Clear(l);
            //Clear(lJSONToken1);
            Clear(lJSONArray1);
            lEzyVetInvoiceLine.Reset();
            if not lEzyVetInvoiceLine.findlast() then
                lLineEntryNo := 0
            else
                lLineEntryNo := lEzyVetInvoiceLine.entry_no;

            lJSONToken.SelectToken('line_item', lJSONToken);
            lJSONArray1 := lJSONToken.AsArray();
            for k := 0 to lJSONArray1.Count - 1 do begin
                l += 1;
                lJSONArray1.Get(k, lJSONToken);
                lJSONObject := lJSONToken.AsObject();
                lEzyVetInvoiceLine.Init();
                lEzyVetInvoiceLine.entry_no := lLineEntryNo + l;
                lEzyVetInvoiceLine.Insert();
                lEzyVetInvoiceLine.id := GetJSONToken(lJSONObject, 'id').AsValue().AsText();
                lEzyVetInvoiceLine.active := GetJSONToken(lJSONObject, 'active').AsValue().AsText();
                lEzyVetInvoiceLine.created_at := GetJSONToken(lJSONObject, 'created_at').AsValue().AsText();
                lEzyVetInvoiceLine.modified_at := GetJSONToken(lJSONObject, 'modified_at').AsValue().AsText();
                lEzyVetInvoiceLine.ownership_id := GetJSONToken(lJSONObject, 'ownership_id').AsValue().AsText();
                lEzyVetInvoiceLine.location_id := GetJSONToken(lJSONObject, 'location_id').AsValue().AsText();
                lEzyVetInvoiceLine.product_id := GetJSONToken(lJSONObject, 'product_id').AsValue().AsText();
                //lEzyVetInvoiceLine.staff_user_id := GetJSONToken(lJSONObject, 'staff_user_id').AsValue().AsText();
                lEzyVetInvoiceLine.invoice_id := lEzyVetInvoiceHeader.id;
                lEzyVetInvoiceLine.quantity := GetJSONToken(lJSONObject, 'quantity').AsValue().AsText();
                lEzyVetInvoiceLine.Dispense := GetJSONToken(lJSONObject, 'dispense').AsValue().AsText();
                lEzyVetInvoiceLine.status := GetJSONToken(lJSONObject, 'status').AsValue().AsText();
                lEzyVetInvoiceLine.tax_code := GetJSONToken(lJSONObject, 'tax_code').AsValue().AsText();
                lEzyVetInvoiceLine.name := GetJSONToken(lJSONObject, 'name').AsValue().AsText();
                lEzyVetInvoiceLine.discount := GetJSONToken(lJSONObject, 'discount').AsValue().AsText();
                lEzyVetInvoiceLine.price := GetJSONToken(lJSONObject, 'price').AsValue().AsText();
                lEzyVetInvoiceLine.price_tax := GetJSONToken(lJSONObject, 'price_tax').AsValue().AsText();
                lEzyVetInvoiceLine.standard_price := GetJSONToken(lJSONObject, 'standard_price').AsValue().AsText();
                lEzyVetInvoiceLine.standard_price_tax := GetJSONToken(lJSONObject, 'standard_price_tax').AsValue().AsText();
                lEzyVetInvoiceLine.total := GetJSONToken(lJSONObject, 'total').AsValue().AsText();
                lEzyVetInvoiceLine.total_tax := GetJSONToken(lJSONObject, 'total_tax').AsValue().AsText();
                lEzyVetInvoiceLine.tax_percent := GetJSONToken(lJSONObject, 'tax_percent').AsValue().AsText();
                //lEzyVetInvoiceLine.animal_id := GetJSONToken(lJSONObject, 'animal_id').AsValue().AsText();
                //lEzyVetInvoiceLine.consult_id := GetJSONToken(lJSONObject, 'consult_id').AsValue().AsText();
                lEzyVetInvoiceLine.created_at_date := EPOCHConvertor.EpochDateTimeToSystemDateTime(GetJSONToken(lJSONObject, 'created_at').AsValue().AsInteger());
                lEzyVetInvoiceLine.modified_at_date := EPOCHConvertor.EpochDateTimeToSystemDateTime(GetJSONToken(lJSONObject, 'modified_at').AsValue().AsInteger());

                lEzyVetInvoiceLine."Header Entry No." := lEzyVetInvoiceHeader.entry_no;
                lEzyVetInvoiceLine.Modify();
            end;
        end;
    end;

    local procedure GetJSONToken(JsonObject: JsonObject;
    TokenKey: Text) JsonToken: JsonToken;
    var
    begin
        if not JsonObject.get(TokenKey, JsonToken) then Error('Could not find a token with key %1', TokenKey);
    end;

    var
        EPOCHConvertor: Codeunit "EzyVet Epoch Convertor";
}
