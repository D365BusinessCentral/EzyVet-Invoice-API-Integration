table 50074 "EzyVet Lock Down Dates"
{
    Caption = 'EzyVet LockDown Dates';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "FY Year"; Integer)
        {
            Caption = 'FY Year';
            DataClassification = CustomerContent;
        }
        field(3; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            DataClassification = CustomerContent;
        }
        field(4; "Transaction Locked Date"; Date)
        {
            Caption = 'Transaction Locked Date';
            DataClassification = CustomerContent;
        }
        field(5; "Day No."; Integer)
        {
            Caption = 'Day No.';
            DataClassification = CustomerContent;
        }
        field(6; Day; Text[30])
        {
            Caption = 'Day';
            DataClassification = CustomerContent;
        }
        field(7; "Week No."; Integer)
        {
            Caption = 'Week No.';
            DataClassification = CustomerContent;
        }
        field(8; Month; Text[30])
        {
            Caption = 'Month';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}
