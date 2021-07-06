table 50071 "EzyVet Invoice Header"
{
    Caption = 'EzyVet Invoice Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; entry_no; Integer)
        {
            Caption = 'entry_no';
            DataClassification = CustomerContent;
        }
        field(2; id; Text[100])
        {
            Caption = 'id';
            DataClassification = CustomerContent;
        }
        field(3; active; Text[10])
        {
            Caption = 'active';
            DataClassification = CustomerContent;
        }
        field(4; created_at; Text[20])
        {
            Caption = 'created_at';
            DataClassification = CustomerContent;
        }
        field(5; modified_at; Text[20])
        {
            Caption = 'modified_at';
            DataClassification = CustomerContent;
        }
        field(6; ownership_id; Text[50])
        {
            Caption = 'ownerwship_id';
            DataClassification = CustomerContent;
        }
        field(7; code; Text[50])
        {
            Caption = 'code';
            DataClassification = CustomerContent;
        }
        field(8; subtotal; Text[80])
        {
            Caption = 'subtotal';
            DataClassification = CustomerContent;
        }
        field(9; tax; Text[80])
        {
            Caption = 'tax';
            DataClassification = CustomerContent;
        }
        field(10; contact_id; Text[80])
        {
            Caption = 'contact_id';
            DataClassification = CustomerContent;
        }
        field(11; animal_id; Text[80])
        {
            Caption = 'animal_id';
            DataClassification = CustomerContent;
        }
        field(12; consult_id; Text[80])
        {
            Caption = 'consult_id';
            DataClassification = CustomerContent;
        }
        field(13; payment_terms_id; Text[80])
        {
            Caption = 'payment_terms_id';
            DataClassification = CustomerContent;
        }
        field(14; includes_tax; Text[80])
        {
            Caption = 'includes_tax';
            DataClassification = CustomerContent;
        }
        field(15; date; Text[40])
        {
            Caption = 'date';
            DataClassification = CustomerContent;
        }
        field(16; due_date; Text[40])
        {
            Caption = 'date_due';
            DataClassification = CustomerContent;
        }
        field(17; customer_reference_number; Text[100])
        {
            Caption = 'customer_reference_number';
            DataClassification = CustomerContent;
        }
        field(18; limit; Text[10])
        {
            Caption = 'limit';
            DataClassification = CustomerContent;
        }
        field(19; page; Text[10])
        {
            Caption = 'page';
            DataClassification = CustomerContent;
        }
        field(20; Processed; Boolean)
        {
            Caption = 'Processed';
            DataClassification = CustomerContent;
        }
        field(21; IsError; Boolean)
        {
            Caption = 'Is Error';
            DataClassification = CustomerContent;
        }
        field(22; "Error Message"; Text[2048])
        {
            Caption = 'Error Message';
            DataClassification = CustomerContent;
        }
        field(23; created_at_date; DateTime)
        {
            Caption = 'created_at_date';
            DataClassification = CustomerContent;
        }
        field(24; modified_at_date; DateTime)
        {
            Caption = 'modified_at_date';
            DataClassification = CustomerContent;
        }


    }
    keys
    {
        key(PK; entry_no)
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        EzyVetInvoiceLine: Record "EzyVet Invoice Line";
    begin
        EzyVetInvoiceLine.Reset();
        EzyVetInvoiceLine.SetRange(invoice_id, id);
        EzyVetInvoiceLine.SetRange("Header Entry No.", entry_no);
        EzyVetInvoiceLine.DeleteAll();
    end;

}
