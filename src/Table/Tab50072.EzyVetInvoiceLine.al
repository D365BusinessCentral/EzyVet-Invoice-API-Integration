table 50072 "EzyVet Invoice Line"
{
    Caption = 'EzyVet Invoice Line';
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
        field(7; location_id; Text[50])
        {
            Caption = 'location_id';
            DataClassification = CustomerContent;
        }
        field(8; product_id; Text[100])
        {
            Caption = 'product_id';
            DataClassification = CustomerContent;
        }
        field(9; staff_user_id; Text[80])
        {
            Caption = 'staff_user_id';
            DataClassification = CustomerContent;
        }
        field(10; invoice_id; Text[100])
        {
            Caption = 'contact_id';
            DataClassification = CustomerContent;
        }
        field(11; quantity; Text[40])
        {
            Caption = 'quantity';
            DataClassification = CustomerContent;
        }
        field(12; status; Text[80])
        {
            Caption = 'status';
            DataClassification = CustomerContent;
        }
        field(13; tax_code; Text[80])
        {
            Caption = 'tax_code';
            DataClassification = CustomerContent;
        }
        field(14; name; text[400])
        {
            Caption = 'name';
            DataClassification = CustomerContent;
        }
        field(15; discount; Text[40])
        {
            Caption = 'discount';
            DataClassification = CustomerContent;
        }
        field(16; price; Text[40])
        {
            Caption = 'price';
            DataClassification = CustomerContent;
        }
        field(17; price_tax; Text[40])
        {
            Caption = 'price_tax';
            DataClassification = CustomerContent;
        }
        field(18; standard_price; Text[40])
        {
            Caption = 'standard_price';
            DataClassification = CustomerContent;
        }
        field(19; standard_price_tax; Text[40])
        {
            Caption = 'standard_price_tax';
            DataClassification = CustomerContent;
        }
        field(20; total; Text[40])
        {
            Caption = 'total';
            DataClassification = CustomerContent;
        }
        field(21; total_tax; Text[40])
        {
            Caption = 'total_tax';
            DataClassification = CustomerContent;
        }
        field(22; tax_percent; Text[40])
        {
            Caption = 'tax_percent';
            DataClassification = CustomerContent;
        }
        field(23; animal_id; Text[100])
        {
            Caption = 'animal_id';
            DataClassification = CustomerContent;
        }
        field(24; consult_id; Text[100])
        {
            Caption = 'consult_id';
            DataClassification = CustomerContent;
        }
        field(25; "Header Entry No."; Integer)
        {
            Caption = 'Header Entry No.';
            DataClassification = CustomerContent;
        }
        field(26; "dispense"; Text[40])
        {
            Caption = 'Dispense';
            DataClassification = CustomerContent;
        }
        field(27; created_at_date; DateTime)
        {
            Caption = 'created_at_date';
            DataClassification = CustomerContent;
        }
        field(28; modified_at_date; DateTime)
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
        key(InvoiceKey; invoice_id, id)
        {

        }
    }

}
