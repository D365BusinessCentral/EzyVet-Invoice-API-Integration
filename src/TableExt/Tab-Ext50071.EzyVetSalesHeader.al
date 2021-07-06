tableextension 50071 EzyVetSalesHeader extends "Sales Header"
{
    fields
    {
        field(50071; "EzyVet Invoice ID"; Text[100])
        {
            Caption = 'EzyVet Invoice ID';
            DataClassification = CustomerContent;
        }
        field(50072; "EzyVet Contact ID"; Text[100])
        {
            Caption = 'EzyVet Contact ID';
            DataClassification = CustomerContent;
        }
        field(50073; "EzyVet Code"; Code[30])
        {
            Caption = 'EzyVet Code';
            DataClassification = CustomerContent;
        }

    }
}
